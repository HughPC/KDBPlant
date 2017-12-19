uTP:(enlist[`zarniwoop]!enlist "lemon_soaked_paper_napkin")
uRDB:(enlist[`zarniwoop]!enlist "lemon_soaked_paper_napkin")
uBB:(enlist[`zarniwoop]!enlist "lemon_soaked_paper_napkin")

addUser:{[dict;username;password] dict upsert enlist[username]!enlist password}

addUser[`uTP;`rdb.q;"pass"];
addUser[`uTP;`fh.q;"pass"];

addUser[`uRDB;`MM.q;"pass"];
addUser[`uRDB;`Auther;"pass"];
addUser[`uRDB;`bot;"pass"];

addUser[`uBB;`MM.q;"pass"];
addUser[`uBB;`fh.q;"pass"];
addUser[`uBB;`Auther;"pass"];
addUser[`uBB;`bot;"pass"];
