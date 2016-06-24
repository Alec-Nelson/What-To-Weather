<?php

class clothing extends DbObject {
    // name of database table
    const DB_TABLE = 'clothing';

    // database fields
    protected $id;
    protected $author_id;
    protected $clothingname;
    protected $clothingtype;
    protected $tempmin;
    protected $tempmax;

    // constructor
    public function __construct($args = array()) {
        $defaultArgs = array(
            'id' => null,
            'author_id' => 0,
            'clothingname' => '',
            'clothingtype' => '',
            'tempmin' => '',
            'tempmax' =>''
            );

        $args += $defaultArgs;

        $this->id = $args['id'];
        $this->author_id = $args['author_id'];
        $this->clothingname = $args['clothingname'];
        $this->clothingtype = $args['clothingtype'];
        $this->tempmin = $args['tempmin'];
        $this->tempmax = $args['tempmax'];
    }

    // save changes to object
    public function save() {
        $db = Db::instance();
        // omit id and any timestamps
        $db_properties = array(
            'author_id' => $this->author_id,
            'clothingname' => $this->clothingname,
            'clothingtype' => $this->clothingtype,
            'tempmin' => $this->tempmin,
            'tempmax' => $this->tempmax
            );
        $db->store($this, __CLASS__, self::DB_TABLE, $db_properties);
    }

    // load object by ID
    public static function loadById($id) {
        $db = Db::instance();
        $obj = $db->fetchById($id, __CLASS__, self::DB_TABLE);
        return $obj;
    }

    // load some clothes
    public static function getAllClothes() {
        $query = sprintf(" SELECT id FROM %s ORDER BY id DESC ",
            self::DB_TABLE
            );
        $db = Db::instance();
        $result = $db->lookup($query);
        if(!mysql_num_rows($result))
            return null;
        else {
            $objects = array();
            while($row = mysql_fetch_assoc($result)) {
                $objects[] = self::loadById($row['id']);
            }
            return ($objects);
        }
    }

    // load all posts on this blog
public static function getClothingById($authorID=null, $limit=null) {
    $query = sprintf(" SELECT c.id AS id FROM %s c
      INNER JOIN %s b ON c.author_id = b.id
      WHERE b.id = %d
      ORDER BY c.id DESC ",
        self::DB_TABLE,
        AppUser::DB_TABLE,
        $authorID
        );
    $db = Db::instance();
    $result = $db->lookup($query);
    if(!mysql_num_rows($result))
        return null;
    else {
        $objects = array();
        while($row = mysql_fetch_assoc($result)) {
            $objects[] = self::loadById($row['id']);
        }
        return ($objects);
    }
}

}
