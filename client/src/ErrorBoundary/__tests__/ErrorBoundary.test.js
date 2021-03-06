import React from 'react'
import { render } from 'setupTests'
import { ErrorBoundaryComponent } from '../ErrorBoundary'

describe('Error Boundary', () => {
  it(`should render error boundary component when there is an error`, () => {
    function Bomb() {
      throw new Error('You dropped the bomb on me.')
    }
    let container
    let topLevelErrors = []
    function handleTopLevelError(event) {
      topLevelErrors.push(event.error)
      event.preventDefault()
    }
    window.addEventListener('error', handleTopLevelError)

    try {
      ;({ container } = render(
        <ErrorBoundaryComponent>
          <Bomb />
        </ErrorBoundaryComponent>
      ))
    } finally {
      window.removeEventListener('error', handleTopLevelError)
    }
    expect(container).toHaveTextContent('Something went wrong.')
    expect(topLevelErrors.length).toBe(1)
  })
})
