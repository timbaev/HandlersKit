//
// HandlersKit
// Copyright © 2020 HeadHunter
// MIT Licence
//

#if canImport(UIKit)
import UIKit
import XCTest
@testable import HandlersKit

final class UIScrollViewTest: XCTestCase {

    func test_didScrollSelfHandler_whenDelegateTriggered_thatHandledObjectIsTheSame() {
        // given
        var handledScrollView: UIScrollView?
        let scrollView = UIScrollView()
        scrollView.didScroll { thatScrollView in
            handledScrollView = thatScrollView
        }

        // when
        scrollView.delegate?.scrollViewDidScroll?(scrollView)

        // then
        XCTAssert(handledScrollView === scrollView)
    }

    func test_didScrollVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var isHandled = false
        let scrollView = UIScrollView()
        scrollView.didScroll {
            isHandled = true
        }

        // when
        scrollView.delegate?.scrollViewDidScroll?(scrollView)

        // then
        XCTAssertTrue(isHandled)
    }

    // MARK: -

    func test_didZoomSelfHandler_whenDelegateTriggered_thatHandledObjectIsTheSame() {
        // given
        var handledScrollView: UIScrollView?
        let scrollView = UIScrollView()
        scrollView.didZoom { thatScrollView in
            handledScrollView = thatScrollView
        }

        // when
        scrollView.delegate?.scrollViewDidZoom?(scrollView)

        // then
        XCTAssert(handledScrollView === scrollView)
    }

    func test_didZoomVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var isHandled = false
        let scrollView = UIScrollView()
        scrollView.didZoom {
            isHandled = true
        }

        // when
        scrollView.delegate?.scrollViewDidZoom?(scrollView)

        // then
        XCTAssertTrue(isHandled)
    }

    // MARK: -

    func test_willBeginDraggingSelfHandler_whenDelegateTriggered_thatHandledObjectIsTheSame() {
        // given
        var handledScrollView: UIScrollView?
        let scrollView = UIScrollView()
        scrollView.willBeginDragging { thatScrollView in
            handledScrollView = thatScrollView
        }

        // when
        scrollView.delegate?.scrollViewWillBeginDragging?(scrollView)

        // then
        XCTAssert(handledScrollView === scrollView)
    }

    func test_willBeginDraggingVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var isHandled = false
        let scrollView = UIScrollView()
        scrollView.willBeginDragging {
            isHandled = true
        }

        // when
        scrollView.delegate?.scrollViewWillBeginDragging?(scrollView)

        // then
        XCTAssertTrue(isHandled)
    }

    // MARK: -

    func test_willEndDraggingSelfHandler_whenDelegateTriggered_thatHandledObjectIsTheSame() {
        // given
        var handledScrollView: UIScrollView?
        let scrollView = UIScrollView()
        scrollView.willEndDragging { thatScrollView, _, _ in
            handledScrollView = thatScrollView
        }

        // when
        scrollView.delegate?.scrollViewWillEndDragging?(
            scrollView,
            withVelocity: .zero,
            targetContentOffset: UnsafeMutablePointer<CGPoint>.allocate(capacity: 5)
        )

        // then
        XCTAssert(handledScrollView === scrollView)
    }

    func test_willEndDraggingVoidHandler_whenDelegateTriggered_thatActionHandled() {
        // given
        var actualVelocity: CGPoint?
        var actualTargetContentOffset: CGPoint?

        let expectedVelocity = CGPoint(x: 5.0, y: 7.0)
        var expectedTargetContentOffset = CGPoint(x: 12.0, y: 2.0)

        let scrollView = UIScrollView()
        scrollView.willEndDragging { velocity, targetContentOffset in
            actualVelocity = velocity
            actualTargetContentOffset = targetContentOffset.pointee
        }

        // when
        scrollView.delegate?.scrollViewWillEndDragging?(
            scrollView,
            withVelocity: expectedVelocity,
            targetContentOffset: &expectedTargetContentOffset
        )

        // then
        XCTAssertEqual(expectedVelocity, actualVelocity)
        XCTAssertEqual(expectedTargetContentOffset, actualTargetContentOffset)
    }
}

#endif
