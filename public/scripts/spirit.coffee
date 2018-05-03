$(document).ready ->
  spiritId = $('#spirit-name').attr('data-id')

  $.ajax({
    'async' : true,
    'crossDomain' : true,
    'headers' :
      'spirit' : spiritId
    ,
    type: 'GET',
    url: '/getSpirit',
    success: (response) => makeAltar(response)
  })

  $.ajax({
    'async' : true,
    'crossDomain' : true,
    'headers' :
      'spirit' : spiritId
    ,
    type: 'GET',
    url: '/getPseudonyms',
    success: (response) => makePseudonyms(response)
  })

  $.ajax({
    'async' : true,
    'crossDomain' : true,
    'headers' :
      'spirit' : spiritId
    ,
    type: 'GET',
    url: '/getRelationships',
    success: (response) => makeRelationships(response)
  })

  $.ajax({
    'async' : true,
    'crossDomain' : true,
    'headers' :
      'spirit' : spiritId
    ,
    type: 'GET',
    url: '/getSignificance',
    success: (response) => makeSignificance(response)
  })

  return

makeAltar = (spirit) ->
  console.log 'got spirits'
  spirits  = spirit[0]
  feed = document.getElementById('main')

  if spirits.length
    spirit = spirits[0]
    $('#spirit-photo').attr('src', spirit['sDefaultPhoto'])
    document.getElementById('spirit-name').innerHTML = spirit['sName']
    document.getElementById('spirit-type').innerHTML = spirit['sType']

    feed.innerHTML += '<p>' + spirit['sInfo'] + '</p>'

  else
    $(feed).html("<h1>No data for this spirit!</h1><p>There is no spirit data to display at this time</p>")

makePseudonyms = (data) ->
  console.log 'got spirits'
  pseudonyms  = data[0]

  pseudonymHTML = 'Pseudonyms: <br>'

  if pseudonyms.length
    for name in pseudonyms
      pseudonymHTML += name['psuedonym'] + ', '

    pseudonymHTML = pseudonymHTML.substring(0, pseudonymHTML.length - 2)

  document.getElementById('pseudonyms').innerHTML = pseudonymHTML

makeRelationships = (data) ->
  console.log 'got relationships'
  relationships  = data[0]

  relationshipsHTML = 'Relationships: <br>'

  if relationships.length
    for name in relationships
      relationshipsHTML += '' +
        name['relationshipDesc'] + ': ' +
        '<a href="/spirit/' + name['s2Id'] + '">' +
        name['sName'] + '</a> <br>'

    relationshipsHTML = relationshipsHTML.substring(0, relationshipsHTML.length - 5)

  document.getElementById('relationships').innerHTML = relationshipsHTML

makeSignificance = (data) ->
  console.log 'got significance'
  reps  = data[0]

  repsHTML = 'Represents: <br>'

  if reps.length
    for rep in reps
      repsHTML += rep['significance'] + ', '

    repsHTML = repsHTML.substring(0, repsHTML.length - 2)

  document.getElementById('significance').innerHTML = repsHTML