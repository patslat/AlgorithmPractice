function Trie() {
  this.root = {};
}

Trie.prototype.build = function (str) {
  node = this.root;
  for (var i = 0; i < str.length; i++) {
    if (node[str[i]]) {
      node = node[str[i]];
    } else {
      node[str[i]] = {};
      node = node[str[i]];
    }
  }
  node["end"] = true;
}

Trie.prototype.find = function (str) {
  node = this.root;
  for (var i = 0; i < str.length; i++ ) {
    if (node[str[i]]) {
      node = node[str[i]];
    } else {
      return false;
    }
  }
  return !!node["end"];
}

Trie.prototype.remove = function (str) {
  node = this.root;
  last_branch = this.root;
  for (var i = 0; i < str.length; i++) {
    if (node === last_branch) first_unique = str[i];
    node = node[str[i]];
    if (Object.keys(node).length > 1) last_branch = node;
  }
  if (Object.keys(node).length > 1) {
    node["end"] = false;
  } else {
    delete last_branch(first_unique);
  }
}


t = new Trie();
t.build("cat");
t.build("hat");
t.build("socrates");
t.build("plato");
t.build("aristotle");
t.build("heraclitus");
t.build("diogenes");
t.build("platano");
t.build("platanos");
t.build("caterpillar")

console.log(t);
console.log("these should work");

console.log(t.find("cat"));
console.log(t.find("hat"));
console.log(t.find("socrates"));
console.log(t.find("plato"));
console.log(t.find("aristotle"));
console.log(t.find("heraclitus"));
console.log(t.find("diogenes"));

console.log("these should be false");

console.log(t.find("cats"));
console.log(t.find("chat"));
console.log(t.find("soc"));
console.log(t.find("aristocat"));
console.log(t.find("herpaclitus"));
console.log(t.find("derpogenes"));

console.log("should be true");

t.remove("cat");
console.log(t.find("caterpillar"));

t.remove("platano");
console.log(t.find("platanos"));

console.log("should be false");
console.log(t.find("cat"));
console.log(t.find("platano"));
