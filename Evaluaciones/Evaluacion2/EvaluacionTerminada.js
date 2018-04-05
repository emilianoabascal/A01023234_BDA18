//1
db.grades.aggregate({
	$group: 
		{_id: '$student_id'}
		},{
	$group: 
		{_id: 1,count: 
			{$sum: 1}
		}
	}
)

	
//Hay 50 alumnos

//2
db.grades.aggregate({
	$group: 
		{_id: '$class_id'}
		},{
	$group: 
		{_id: 1,count: 
			{$sum: 1}
		}
	}
)

//Hay 31 clases



//3

var map = function(){
	this.scores.forEach(
		(value)=>{
			emit(this.student_id, value.score)
			}
		);
};

var reduce = function(name, value){
	var n = Array.avg(value);
	return n;
};

db.grades.mapReduce(
	map,
	reduce,
	{
		out:"res"
	}
)

//4
db.grades.aggregate([{
	$unwind : "$scores"},{
		$group:{
			_id:{
				clase:"$class_id",
				Estudiante:"$student_id",
				Calificacion:{
					$min: "$scores.score"}
					}
				}
			}, {
				"$sort":{
					'estudiante':-1
					}
				},{
					"$limit":1
				}
			]
		);

//Clase 29


//5

db.grades.aggregate([{
	$unwind : "$scores"},{
		$match:{"scores.type":'homework'
		}
	},{
	$group:{
		_id: "$class_id",
		tareas: {
			$sum: 1
			}
		}
	},{
		"$sort":{
			'tareas':-1
			}
		},{
			"$limit":1
			}
		]
	);
//La materia que mas ha dejado tareas es la 22


//6
db.grades.aggregate([{
	$group:{
		_id: "$student_id",
		count:{
			$sum: 1
			}
		}
	},{
		$sort:{
			count:-1
			}
		}, {
			$limit :1
			}
		]
	)
//El estudiante 40

//7

db.grades.aggregate([{
	$unwind : "$scores"
	},{
		$group:{
			_id: {
				class:"$class_id",student:"$student_id"
				},prom: {
					$avg: "$scores.score"
					}
				}
			},{
				$match:{
					"prom":{
						"$lt":70
						}
					}
				},{
					$group:{
						_id:"$_id.class",
						count:{$sum: 1}
						}
					},{
						"$sort":{
							'count':-1
							}
						},{
							"$limit":10
							}
						]
					);
//La clase 22