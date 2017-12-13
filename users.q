uTP:(enlist[`zarniwoop]!enlist "lemon_soaked_paper_napkin")
uRDB:(enlist[`zarniwoop]!enlist "lemon_soaked_paper_napkin")
uBB:(enlist[`zarniwoop]!enlist "lemon_soaked_paper_napkin")

addUser:{[dict;username;password] dict upsert enlist[username]!enlist password}
/addUserTP:{[username;password]usersTP+:enlist[username]!enlist password}
/addUserRDB:{[username;password]usersRDB+:enlist[username]!enlist password}
/addUserBB:{[username;password]usersBB+:enlist[username]!enlist password}

addUser[`uTP;`rdb.q;"pass"];
addUser[`uTP;`fh.q;"pass"];

addUser[`uRDB;`MM.q;"pass"];
addUser[`uRDB;`Auther;"pass"];

addUser[`uBB;`MM.q;"pass"];
addUser[`uBB;`fh.q;"pass"];
addUser[`uBB;`Auther;"pass"];

/addUserTP[`rdb.q;"pass"]
/addUserTP[`fh.q;"pass"]

/addUserRDB[`MM.q;"pass"]
/addUserRDB[`Auther;"pass"]


/addUserBB[`MM.q;"pass"]
/addUserBB[`fh.q;"pass"]
/addUserBB[`Auther;"pass"]