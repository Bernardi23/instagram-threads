class User {
  User({
    this.username,
    this.img,
    this.status = "Online 1 hour ago",
    this.lastmsg,
    this.notification = false,
    this.hasStory = false,
    this.hasSeenStory = false,
  }) {
    if (this.status == "Active now") {
      this.active = true;
    } else {
      this.active = false;
    }
  }

  String username;
  String status;
  String img;
  bool active;
  String lastmsg;
  bool notification;
  bool hasStory;
  bool hasSeenStory;
}

final users = [
  User(
    username: "phillsohn",
    status: "Active now",
    img: "https://randomuser.me/api/portraits/men/47.jpg",
    lastmsg: "Sounds good",
    notification: true,
    hasStory: true,
    hasSeenStory: false,
  ),
  User(
      username: "_christysilva",
      status: "At home",
      img: "https://randomuser.me/api/portraits/women/60.jpg",
      lastmsg: "don't be late",
      notification: true,
      hasStory: true,
      hasSeenStory: false),
  User(
    username: "dantoffey",
    status: "On the move",
    img: "https://randomuser.me/api/portraits/men/19.jpg",
    lastmsg: "You sent a photo",
    hasStory: true,
    hasSeenStory: true,
  ),
  User(
    username: "deitch",
    status: "Active now",
    img: "https://randomuser.me/api/portraits/women/28.jpg",
    lastmsg: "ready when you are",
  ),
  User(
    username: "alexthebez",
    img: "https://randomuser.me/api/portraits/men/33.jpg",
    lastmsg: "how are you?",
    hasStory: true,
  ),
  User(
    username: "lucas.bernardi2",
    status: "Sleeping",
    img: "https://randomuser.me/api/portraits/men/32.jpg",
    lastmsg: "I'm tired",
    hasStory: true,
    hasSeenStory: true,
  ),
  User(
    username: "felipe.gustavo",
    status: "On the move",
    img: "https://randomuser.me/api/portraits/men/18.jpg",
    lastmsg: "You sent a photo",
  ),
  User(
    username: "deitch",
    status: "Active now",
    img: "https://randomuser.me/api/portraits/women/49.jpg",
    lastmsg: "ready when you are",
  ),
  User(
    username: "alexthebez",
    img: "https://randomuser.me/api/portraits/men/33.jpg",
    lastmsg: "how are you?",
  ),
  User(
    username: "lucas.bernardi2",
    status: "Sleeping",
    img: "https://randomuser.me/api/portraits/men/32.jpg",
    lastmsg: "I'm tired",
  ),
];
