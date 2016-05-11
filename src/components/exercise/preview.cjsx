React = require 'react'
_ = require 'underscore'
BS = require 'react-bootstrap'
classnames = require 'classnames'
Location = require 'stores/location'

{ExercisePreview} = require 'openstax-react-components'

{ExerciseActions, ExerciseStore} = require 'stores/exercise'

ExercisePreviewWrapper = React.createClass

  propTypes:
    exerciseId: React.PropTypes.string.isRequired

  componentWillMount: ->
    ExerciseStore.addChangeListener(@update)
    unless ExerciseStore.isLoading(@props.exerciseId) or ExerciseStore.get(@props.exerciseId)
      ExerciseActions.load(@props.exerciseId)

  componentWillUnmount: ->
    ExerciseStore.removeChangeListener(@update)

  update: -> @forceUpdate()

  previewData: (ex) ->
    content: ex
    tags: _.map ex.tags, (tag) -> name: tag

  render: ->
    exercise = ExerciseStore.get(@props.exerciseId)
    return null unless exercise

    <ExercisePreview
      exercise={@previewData(exercise)}
      displayAllTags={true}
      displayFormats={true}
      displayFeedback={true}
      hideAnswers={false}
    />

module.exports = ExercisePreviewWrapper
