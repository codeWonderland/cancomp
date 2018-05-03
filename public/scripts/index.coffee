$(document).ready ->
  spirits = ''

  if localStorage.getItem('cancomp-spirits') isnt null
    cancompData = $.parseJSON localStorage.getItem 'cancomp-spirits'

    # 2 hours in milliseconds
    twoHours = 1000 * 60 * 60 * 2

    now = new Date().getTime()

    if cancompData.date && now - cancompData.date < twoHours
      spirits = cancompData.spirits
      makeAltar(spirits)
    else
      spirits = null
  else
    spirits = null

  if not spirits
    console.log 'fetching spirits'

    $.ajax({
      'async' : true,
      'crossDomain' : true
      ,
      type: 'GET',
      url: '/getSpirits',
      success: (response) => makeAltar(response)
    })

  return

makeAltar = (spirits) ->
  console.log 'got spirits'
  spirits  = spirits[0]
  feed = document.getElementById('main')

  feed.innerHTML = ''

  if spirits.length
    spirits.forEach((spirit) =>
      spiritHTML = '' +
        '<a href="/spirit/' + spirit['sId'] + '">' +
        '<div class="spirit card">' +
        ' <img class="spirit-photo" src="' + spirit['sDefaultPhoto'] + '" alt="Spirit Image">' +
        ' <div class="spirit-preview">' +
        '   <p class="spirit-name">' + spirit['sName'] + '</p>' +
        ' </div>' +
        '</div>' +
        '</a>'
      feed.innerHTML += spiritHTML
    )

  else
    $(feed).html("<h1>Your feed Is Empty!</h1><p>There are no spirits to display at this time</p>")
