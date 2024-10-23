PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE log (
	id INTEGER NOT NULL, 
	dttm TIMESTAMP, 
	dag_id VARCHAR(250), 
	task_id VARCHAR(250), 
	map_index INTEGER, 
	event VARCHAR(30), 
	execution_date TIMESTAMP, 
	owner VARCHAR(500), 
	extra TEXT, 
	CONSTRAINT log_pkey PRIMARY KEY (id)
);
INSERT INTO log VALUES(1,'2024-10-21 18:02:07.513384',NULL,NULL,NULL,'cli_webserver',NULL,'root','{"host_name": "MacBook-Air-de-Pedro.local", "full_command": "[''/private/var/root/devs/api_wpp/apache_airflows/airflowers/.venv/bin/airflow'', ''webserver'']"}');
INSERT INTO log VALUES(2,'2024-10-21 18:02:07.722782',NULL,NULL,NULL,'cli_triggerer',NULL,'root','{"host_name": "MacBook-Air-de-Pedro.local", "full_command": "[''/private/var/root/devs/api_wpp/apache_airflows/airflowers/.venv/bin/airflow'', ''triggerer'']"}');
INSERT INTO log VALUES(3,'2024-10-21 18:02:07.954064',NULL,NULL,NULL,'cli_scheduler',NULL,'root','{"host_name": "MacBook-Air-de-Pedro.local", "full_command": "[''/private/var/root/devs/api_wpp/apache_airflows/airflowers/.venv/bin/airflow'', ''scheduler'']"}');
INSERT INTO log VALUES(4,'2024-10-21 18:57:56.065458',NULL,NULL,NULL,'cli_upgradedb',NULL,'root','{"host_name": "MacBook-Air-de-Pedro.local", "full_command": "[''/private/var/root/devs/api_wpp/apache_airflows/airflowers/.venv/bin/airflow'', ''db'', ''upgrade'']"}');
INSERT INTO log VALUES(5,'2024-10-21 18:58:12.102886',NULL,NULL,NULL,'cli_webserver',NULL,'root','{"host_name": "MacBook-Air-de-Pedro.local", "full_command": "[''/private/var/root/devs/api_wpp/apache_airflows/airflowers/.venv/bin/airflow'', ''webserver'']"}');
INSERT INTO log VALUES(6,'2024-10-21 18:58:12.222394',NULL,NULL,NULL,'cli_triggerer',NULL,'root','{"host_name": "MacBook-Air-de-Pedro.local", "full_command": "[''/private/var/root/devs/api_wpp/apache_airflows/airflowers/.venv/bin/airflow'', ''triggerer'']"}');
INSERT INTO log VALUES(7,'2024-10-21 18:58:12.558211',NULL,NULL,NULL,'cli_scheduler',NULL,'root','{"host_name": "MacBook-Air-de-Pedro.local", "full_command": "[''/private/var/root/devs/api_wpp/apache_airflows/airflowers/.venv/bin/airflow'', ''scheduler'']"}');
INSERT INTO log VALUES(8,'2024-10-21 18:58:44.964019',NULL,NULL,NULL,'cli_dag_list_dags',NULL,'root','{"host_name": "MacBook-Air-de-Pedro.local", "full_command": "[''/private/var/root/devs/api_wpp/apache_airflows/airflowers/.venv/bin/airflow'', ''dags'', ''list'']"}');
CREATE TABLE dag_code (
	fileloc_hash BIGINT NOT NULL, 
	fileloc VARCHAR(2000) NOT NULL, 
	last_updated TIMESTAMP NOT NULL, 
	source_code TEXT NOT NULL, 
	CONSTRAINT dag_code_pkey PRIMARY KEY (fileloc_hash)
);
INSERT INTO dag_code VALUES(37343288193572262,'/private/var/root/devs/api_wpp/apache_airflows/airflowers/dags/example_dag_basic.py','2024-10-21 18:01:51.858080',replace('import json\n\nfrom airflow.decorators import (\n    dag,\n    task,\n)\nfrom pendulum import datetime\n\n\n# When using the DAG decorator, The "dag_id" value defaults to the name of the function\n# it is decorating if not explicitly set. In this example, the "dag_id" value would be "example_dag_basic".\n@dag(\n    # This defines how often your DAG will run, or the schedule by which your DAG runs. In this case, this DAG\n    # will run daily\n    schedule="@daily",\n    # This DAG is set to run for the first time on January 1, 2023. Best practice is to use a static\n    # start_date. Subsequent DAG runs are instantiated based on the schedule\n    start_date=datetime(2023, 1, 1),\n    # When catchup=False, your DAG will only run the latest run that would have been scheduled. In this case, this means\n    # that tasks will not be run between January 1, 2023 and 30 mins ago. When turned on, this DAG''s first\n    # run will be for the next 30 mins, per the its schedule\n    catchup=False,\n    default_args={\n        "retries": 2,  # If a task fails, it will retry 2 times.\n    },\n    tags=["example"],\n)  # If set, this tag is shown in the DAG view of the Airflow UI\ndef example_dag_basic():\n    """\n    ### Basic ETL Dag\n    This is a simple ETL data pipeline example that demonstrates the use of\n    the TaskFlow API using three simple tasks for extract, transform, and load.\n    For more information on Airflow''s TaskFlow API, reference documentation here:\n    https://airflow.apache.org/docs/apache-airflow/stable/tutorial_taskflow_api.html\n    """\n\n    @task()\n    def extract():\n        """\n        #### Extract task\n        A simple "extract" task to get data ready for the rest of the\n        pipeline. In this case, getting data is simulated by reading from a\n        hardcoded JSON string.\n        """\n        data_string = ''{"1001": 301.27, "1002": 433.21, "1003": 502.22}''\n\n        order_data_dict = json.loads(data_string)\n        return order_data_dict\n\n    @task(multiple_outputs=True)  # multiple_outputs=True unrolls dictionaries into separate XCom values\n    def transform(order_data_dict: dict):\n        """\n        #### Transform task\n        A simple "transform" task which takes in the collection of order data and\n        computes the total order value.\n        """\n        total_order_value = 0\n\n        for value in order_data_dict.values():\n            total_order_value += value\n\n        return {"total_order_value": total_order_value}\n\n    @task()\n    def load(total_order_value: float):\n        """\n        #### Load task\n        A simple "load" task that takes in the result of the "transform" task and prints it out,\n        instead of saving it to end user review\n        """\n\n        print(f"Total order value is: {total_order_value:.2f}")\n\n    order_data = extract()\n    order_summary = transform(order_data)\n    load(order_summary["total_order_value"])\n\n\nexample_dag_basic()\n','\n',char(10)));
CREATE TABLE dag_pickle (
	id INTEGER NOT NULL, 
	pickle BLOB, 
	created_dttm TIMESTAMP, 
	pickle_hash BIGINT, 
	CONSTRAINT dag_pickle_pkey PRIMARY KEY (id)
);
CREATE TABLE slot_pool (
	id INTEGER NOT NULL, 
	pool VARCHAR(256), 
	slots INTEGER, 
	description TEXT, 
	CONSTRAINT slot_pool_pkey PRIMARY KEY (id), 
	CONSTRAINT slot_pool_pool_uq UNIQUE (pool)
);
INSERT INTO slot_pool VALUES(1,'default_pool',128,'Default pool');
CREATE TABLE dataset (
	id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
	uri VARCHAR(3000) NOT NULL, 
	extra JSON NOT NULL, 
	created_at TIMESTAMP NOT NULL, 
	updated_at TIMESTAMP NOT NULL
);
CREATE TABLE dataset_event (
	id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
	dataset_id INTEGER NOT NULL, 
	extra JSON NOT NULL, 
	source_task_id VARCHAR(250), 
	source_dag_id VARCHAR(250), 
	source_run_id VARCHAR(250), 
	source_map_index INTEGER DEFAULT -1, 
	timestamp TIMESTAMP NOT NULL
);
CREATE TABLE log_template (
	id INTEGER NOT NULL, 
	filename TEXT NOT NULL, 
	elasticsearch_id TEXT NOT NULL, 
	created_at TIMESTAMP NOT NULL, 
	CONSTRAINT log_template_pkey PRIMARY KEY (id)
);
INSERT INTO log_template VALUES(1,'{{ ti.dag_id }}/{{ ti.task_id }}/{{ ts }}/{{ try_number }}.log','{dag_id}-{task_id}-{execution_date}-{try_number}','2024-10-21 18:01:46.571296');
INSERT INTO log_template VALUES(2,'dag_id={{ ti.dag_id }}/run_id={{ ti.run_id }}/task_id={{ ti.task_id }}/{% if ti.map_index >= 0 %}map_index={{ ti.map_index }}/{% endif %}attempt={{ try_number }}.log','{dag_id}-{task_id}-{run_id}-{map_index}-{try_number}','2024-10-21 18:01:46.576336');
CREATE TABLE dag (
	dag_id VARCHAR(250) NOT NULL, 
	root_dag_id VARCHAR(250), 
	is_paused BOOLEAN, 
	is_subdag BOOLEAN, 
	is_active BOOLEAN, 
	last_parsed_time TIMESTAMP, 
	last_pickled TIMESTAMP, 
	last_expired TIMESTAMP, 
	scheduler_lock BOOLEAN, 
	pickle_id INTEGER, 
	fileloc VARCHAR(2000), 
	processor_subdir VARCHAR(2000), 
	owners VARCHAR(2000), 
	description TEXT, 
	default_view VARCHAR(25), 
	schedule_interval TEXT, 
	timetable_description VARCHAR(1000), 
	max_active_tasks INTEGER NOT NULL, 
	max_active_runs INTEGER, 
	has_task_concurrency_limits BOOLEAN NOT NULL, 
	has_import_errors BOOLEAN DEFAULT '0', 
	next_dagrun TIMESTAMP, 
	next_dagrun_data_interval_start TIMESTAMP, 
	next_dagrun_data_interval_end TIMESTAMP, 
	next_dagrun_create_after TIMESTAMP, 
	CONSTRAINT dag_pkey PRIMARY KEY (dag_id)
);
INSERT INTO dag VALUES('example_dag_basic',NULL,1,0,1,'2024-10-21 19:07:49.707806',NULL,NULL,NULL,NULL,'/private/var/root/devs/api_wpp/apache_airflows/airflowers/dags/example_dag_basic.py','/private/var/root/devs/api_wpp/apache_airflows/airflowers/dags','airflow',NULL,'grid','"@daily"','At 00:00',16,16,0,0,'2024-10-20 00:00:00.000000','2024-10-20 00:00:00.000000','2024-10-21 00:00:00.000000','2024-10-21 00:00:00.000000');
CREATE TABLE connection (
	id INTEGER NOT NULL, 
	conn_id VARCHAR(250) NOT NULL, 
	conn_type VARCHAR(500) NOT NULL, 
	description VARCHAR(5000), 
	host VARCHAR(500), 
	schema VARCHAR(500), 
	login VARCHAR(500), 
	password VARCHAR(5000), 
	port INTEGER, 
	is_encrypted BOOLEAN, 
	is_extra_encrypted BOOLEAN, 
	extra TEXT, 
	CONSTRAINT connection_pkey PRIMARY KEY (id), 
	CONSTRAINT connection_conn_id_uq UNIQUE (conn_id)
);
INSERT INTO connection VALUES(1,'airflow_db','mysql',NULL,'mysql','airflow','root',NULL,NULL,0,0,NULL);
INSERT INTO connection VALUES(2,'aws_default','aws',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL);
INSERT INTO connection VALUES(3,'azure_batch_default','azure_batch',NULL,NULL,NULL,'<ACCOUNT_NAME>',NULL,NULL,0,1,'gAAAAABnFpcPYcuUAbOEHmeK8mB7qhkXBoiCK3-pUJcIeuElqCgrjXt-B-Q2PqPgzGXB3vkj_9OemzZI2KBPC9AmjMPr01wgfiuexJsVNJlN56XcB6YdXGRHR3X_RAv8aQVJyyJwRULd');
INSERT INTO connection VALUES(4,'azure_cosmos_default','azure_cosmos',NULL,NULL,NULL,NULL,NULL,NULL,0,1,'gAAAAABnFpcRHj5OlcusB_A0QKVY2-vzrkb0qAWKkY9S3Di0SiniwZUnilNRkaQgJCAw-57I3EZdmxtURADM4iAxE2gyEpEvo11P8hpgRpvMxz4PYGqpiZDewDXoUU7FhgBtOov1p2bhZhKu7i2bRUw71LcvdI_EfgmSaTZik8jCIIV_4NeoNm8=');
INSERT INTO connection VALUES(5,'azure_data_explorer_default','azure_data_explorer',NULL,'https://<CLUSTER>.kusto.windows.net',NULL,NULL,NULL,NULL,0,1,'gAAAAABnFpcRUnl9KI6eNsGyFDfL7OZYwjo1UaA80nvxYkMTS78exmdcuLwTfGVzFFJnkBkYX8Nr8xGtKw4jcfdfhKTcWvtrsWU1JvcEqNz43KSSnrjl18YYzTZA5bfWN5uF0goLAjvKS0r50h_DVcmuqpEG-Wpyb-3lpUWJfCSUBN17fMZ7o4A09B-BEZhV65VA729QCKTedessG8JqJkGmvjW45I8JUbcNYo5x6Y0saCfRTpowXOeutlbtB-_y8U8fLLV9YYjboFXEH7eAcwIpwKUrtCEVjDUsc8a6uT6_bqjfFD13d6vQ5JGZgaE6Bszm8C2uvJNadXAZQPmcx2vZXT-ZMMOi3-km9z_1F4jTGW7-DA0L_vgSJc-I05iU6pyp_TibeQ9h');
INSERT INTO connection VALUES(6,'azure_data_lake_default','azure_data_lake',NULL,NULL,NULL,NULL,NULL,NULL,0,1,'gAAAAABnFpcR-M8Tho1UUOyxAzrsk6aIWogdcKqQDOo3mt-DizDG4W-l3kE3TuyKRRPVDF_gcQS_rPRIEJRE1zuhXfIJl-evPvMLg5ajbvOBa0wdINkYUhlH-C78S3ZZ0b7vLAhaV6MKgWGrkiqAr4Tzd9nm43j1NQ==');
INSERT INTO connection VALUES(7,'azure_default','azure',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL);
INSERT INTO connection VALUES(8,'cassandra_default','cassandra',NULL,'cassandra',NULL,NULL,NULL,9042,0,0,NULL);
INSERT INTO connection VALUES(9,'databricks_default','databricks',NULL,'localhost',NULL,NULL,NULL,NULL,0,0,NULL);
INSERT INTO connection VALUES(10,'dingding_default','http',NULL,'',NULL,NULL,NULL,NULL,0,0,NULL);
INSERT INTO connection VALUES(11,'drill_default','drill',NULL,'localhost',NULL,NULL,NULL,8047,0,1,'gAAAAABnFpcRFhupJo8BLbPotx-5ewg32tnag95cQAB45jKLzUOzrS4EmcZdhRGQThlGFueQfWNKYdd_MwgvifyUlxPdPCV7U4jHRKQ9CQKGKyvPYarRWsHMo7P3MKjSzOEK3L5Ha_CUDmzm3VoQAfIWIyFxJTdH9Q==');
INSERT INTO connection VALUES(12,'druid_broker_default','druid',NULL,'druid-broker',NULL,NULL,NULL,8082,0,1,'gAAAAABnFpcR-kfFtKO8ZffafCQLXUv90ofsiYYs3J-hbGdXKpBzG1zvW_XBx5f35b-nIt8KQRYUUGB0KK38ADmROdtLdCo35kTK7wGxMo-2hGu2loyP14A=');
INSERT INTO connection VALUES(13,'druid_ingest_default','druid',NULL,'druid-overlord',NULL,NULL,NULL,8081,0,1,'gAAAAABnFpcRg2DLNRdXUj6z2ZClu31Nt0weVR-MR4330uqUVZfcjmJrfWR5j4DfSKG5m4rIqxYjchKAW6-sDet3gJ8y5_-wM-RanDx51bFLfVaodxyuhdUHyjygN2c_u6QKSeKVac9W');
INSERT INTO connection VALUES(14,'elasticsearch_default','elasticsearch',NULL,'localhost','http',NULL,NULL,9200,0,0,NULL);
INSERT INTO connection VALUES(15,'emr_default','emr',NULL,NULL,NULL,NULL,NULL,NULL,0,1,'gAAAAABnFpcRVbwV9jHfV8GPhvJ21kbliVu0F226VNFImF67rpUzPnS9yxAy6d4rpQpI9a54yBnmAUk5k-vJiV8UXQGOyOaR8Qq9mnSBOTksmgqKO-A3Nl75SqmcIKbBpS62JJdaseK98EiUXUmWcY6BYboBpJoXqWLumW2GYkWpNxVz3TWGd9i2Fy6lLWPte2fHYKWpmGPUwsCDp_TuwKt9pahmBBmfF4u7vtrRV_fasm9KziqENhXa8oNbXmlLbgUQoDF02ZLWvphbX7c-hG9KvTT0dg8qUZiawdArOFWU92HG8nLzCUfmQQpYuOmnKaorFt5HZZkkCdPCulLKjOJqNyG2hbLPBa2VutT-zSbzxyyJ0r7KTz0AkenVD8bXiNb1MnSi_0RjAIUGLE07ZXa9pTl88nhtAM21Pw0-LDHNRmBsJW9xiBpcAwuEb5FUXGaPpEXs5L1SgrCT1Kh9vNS9ZMYlTa-fFBYEvSCdTDFrqOqDufInFkmkI-iFJAjN9vApEltmSx6NHyA16uNINgE4jUYjsij_IlpFqjtRm0FyFbWOMcugZkg4kx3Qy8QS-n0Tz3jnHZDQB0Ls_CpPNIrPlNgWM2vjZ6rVhOUFa7NMpidpRH8EnYOCZ3e6CYKCLKc8s4um1tyX12Dlhw8uKSz8gGkGapzj3lZYBpXL09fBhHjtrvJwBVDD_0b8nmIXqmhNpxJGmfYKi5VlxyMOZmQZYFt4y_mtlp7JW0tBa3k_-X-v5xlbTuFkA1ifOkLmGFL6IlTpar2qJpbto5hRC-mhCBw1a3611zds74eNiQGGmGEIR0kl90qXUzZGqzcdsCETDabRtLMplzraSPanRKoo9Zat06Ng1RFE-vruUYMZhsjNMXBsqfFtUBkFgZ7twmJCY6va-qBcu-b7lRfH1ahwxeNs9qaFXM_kNxydIllULSf-ldxo0hsdhnzTFuSchxIi7iELRYapcwvqBTh4SqGv4jTxAbEKLqdKprmO4ZHg7OnkK4o2BvnQ1-ewhZGcsV_TeYP1v2P1aee2CvG6bWlXZ-iuDpTY4EGXyaK-rumTP3Xk2NUJ0ohxDkMQGl-vCb-5ujsOYgjdAYTkuUMbZORDEt_1Pf03j9LxNrFty1aHiH4TLnlkihk7VQiR342wdXCUMSd--mZm7Pus7LvMElWx0rYxNF8D6ok8L_zthnrIuqy3Ujcnpy9zSbGJhnu2O8ivUZ2Tevm3qkXvLQtn1BxJ3ij5XA-sxOaqzSL1DLUOyegpNd5MXgQa6rHIRTu5tMWRO7CuWeM5YbIwYLTbRfShAuwsmr-iuZdnTPQfP3CeGCfK7Nk7Q7nsaXjvHF4TRmexCdVTJm15ayc5-5wTRYxHzyDI8UdeuidGrnn1dOP1Dh-4QTWTbz_pfj39jt0aisahjvb7N0HlmVrJlBnCtHVLRbUKNJcEZ6i8gcIDVjP535FVrQtI4oZzANFAXLimsapH6UYJ-fDMCfpvDJup2gLxHZtLoCQZvd0Q2YD2EoWdHEjNF9t1-1JnUPJPJwdeKWkvB1oekrPI-bKFMFKymwNuS_s1Sbw1Gp2kdGKVbXWdqFA8khL_2bj8O7IGQoYo6HaDvUXRjAlwsktaixDU_DIrZIoIdYON-qpbV9Y2NVz7hyp2R_cjn8VxcS4JwIAVGHSYfqclYqAl5NCQeipvJ6VYELWurybigfBKoiYNROVZCJJaFEya0G2KY3kyKpBXFaCPYkwvYBZj9fQfw2Infh_mNmMSUoPmO89MX8UFT72Ubcz3PVaxUCiiq8Qj9xvo4O8nWvh6s6l9ce9MN6kvCS48RuJzMEAM92s2y-ha86ERnj6A72UXYlWP7bBekqQER8rxCm1Ee2ZFOf7jK9_NopFKdeMgi_j6bILDWFgYtqsXy6F0kZ7P827kxvcJy1I6YXaM3mlfhSgxmDbzsGuldyZYht0x1jFKtjxSZpcR5P7Vu_0alvaMUKdh7gPbPURlcpsNeLlrRqHGZeCY6Gxs4bz_Dt6D4TrxMuIvLo4ca6xoJ2-RcLZN9lG5A0MDW5mvPaZR8R9TCASsHr840nT0wu4Aiy3vHwibDrxq8SQdjvMD1HxnaBNFq8uGrAJrA4inHAgEJFifzQeAzx5MoDAa0_67PhwoY-dkAZr4y0JGknryRKggPI-hVJwe_xT7_Ktklix_iC66T1RgoVFtplP3bfvUioNZWku8ljGZ-U6IwfRwRK-gurYppsXLT1pfftHGvcR1M0TlcIkKnnae-wZ-6J5hB72f6nhhRkckefVaPoKwqqyxw-qVX4gBrGd9rrfOqFGIo5OLOYDP-hyjXHFU8EVdkDgElGIEQd-Bpw2eqs_AvQYkpOMrGlYQlDpT3tzt83YJBGH9y0iIYD_FwGiLZkfG_oCPqA9rS19V8t8WHa_gwaTKh3zKLvUAK-cZeUulgXwQgFURGAVFtHfChtehvxuObbhp0KFLs7Vbws0WJlitqKA9iH2NGgAdDRs-MH5XRApGpiW_C0k9Gdo88Dt6UuzQUfUwniXZEOxDtQ2gWvfom9_DQWLO5TI=');
INSERT INTO connection VALUES(16,'facebook_default','facebook_social',NULL,NULL,NULL,NULL,NULL,NULL,0,1,'gAAAAABnFpcRZuDaTEnzPgiL4bqKQG-od5CFEk0Rq-GKcP-we6dcKMQS2afUF8LOTCQxh1NUtCfBqLv-sSVgEYFuYsNMzgbEppHh2jgkjW5AXLWEvAKJ75-b7ZnFviuZFAw360geN-mrJsSk-RWaIWr9kpK5LG5nJJwy5ucgfbHTJRZbVk2sQNKxNUf3O5P2ZMjTnUodbwEbm4tA3PsKAYTH5N71OK-UHrrlbYESvvUQfmW4xV83FLOcUMZpPFHB4RD21lKYVbyWDFphOZP1u4L-Ci0UzDRlTryiFekA4lrFLqgCajY_36uMB0uZGd1KTkY5qH266LT3UGt5fJdiKuUtAp0dYuVR0q8iTYOcBVx05CJIJGo15t3IZpt5d1-P2hY-v7fYCwBw6M7mgLDDou2uPwt9l4JmlBl_J1hSXZSo7JxplwWWur0=');
INSERT INTO connection VALUES(17,'fs_default','fs',NULL,NULL,NULL,NULL,NULL,NULL,0,1,'gAAAAABnFpcRWGmXAgnZfdIhw8ObZuqKMO5sS_BAX9ScOzleiUnt5uxf-aA9Ge0DtqCr0LCDiwxhFwfvbltD6hDrOi2PtnJk-A==');
INSERT INTO connection VALUES(18,'google_cloud_default','google_cloud_platform',NULL,NULL,'default',NULL,NULL,NULL,0,0,NULL);
INSERT INTO connection VALUES(19,'hive_cli_default','hive_cli',NULL,'localhost','default',NULL,NULL,10000,0,1,'gAAAAABnFpcR51wJN63eNpGFK277QJ-mAQ1Xgp-6zJUpVPK2vXjvDgAGPDxci5rMetbn4eP3RNNds5QtXNyXflkjxxg-Q2Za-UtKggggJl3LFwloRvM5B1VJc2y1TmCLKlp-w20jsxgc');
INSERT INTO connection VALUES(20,'hiveserver2_default','hiveserver2',NULL,'localhost','default',NULL,NULL,10000,0,0,NULL);
INSERT INTO connection VALUES(21,'http_default','http',NULL,'https://www.httpbin.org/',NULL,NULL,NULL,NULL,0,0,NULL);
INSERT INTO connection VALUES(22,'kubernetes_default','kubernetes',NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL);
INSERT INTO connection VALUES(23,'kylin_default','kylin',NULL,'localhost',NULL,'ADMIN','gAAAAABnFpcRccfS78xebLvCW7jBhsSTVhk34AZJhAi8GpWquFFO1NslBySL_LjWaSw8k08Ssl8iiY9tTDtuhfMFnPVRmWwFrA==',7070,1,0,NULL);
INSERT INTO connection VALUES(24,'leveldb_default','leveldb',NULL,'localhost',NULL,NULL,NULL,NULL,0,0,NULL);
INSERT INTO connection VALUES(25,'livy_default','livy',NULL,'livy',NULL,NULL,NULL,8998,0,0,NULL);
INSERT INTO connection VALUES(26,'local_mysql','mysql',NULL,'localhost','airflow','airflow','gAAAAABnFpcRxu1tL8KwOc2eX-9n-XsRgi4iSqwjFCpNdWs8m1xeSZXt9rEN_mohwV--IxhehVdd1ImqyuA1MgxBTHw5D2IPYw==',NULL,1,0,NULL);
INSERT INTO connection VALUES(27,'metastore_default','hive_metastore',NULL,'localhost',NULL,NULL,NULL,9083,0,1,'gAAAAABnFpcRQWMmYKGA4YP9R34Ugk4aa9-mUwWBqeeaKVpgDREnN1sCN5yJ-iZMHo0Duas5H9JLxty_bQSVwdHeRPabqJ2ozGQh2k8KZVYGPebNUUL4QyU=');
INSERT INTO connection VALUES(28,'mongo_default','mongo',NULL,'mongo',NULL,NULL,NULL,27017,0,0,NULL);
INSERT INTO connection VALUES(29,'mssql_default','mssql',NULL,'localhost',NULL,NULL,NULL,1433,0,0,NULL);
INSERT INTO connection VALUES(30,'mysql_default','mysql',NULL,'mysql','airflow','root',NULL,NULL,0,0,NULL);
INSERT INTO connection VALUES(31,'opsgenie_default','http',NULL,'',NULL,NULL,NULL,NULL,0,0,NULL);
INSERT INTO connection VALUES(32,'oss_default','oss',NULL,NULL,NULL,NULL,NULL,NULL,0,1,'gAAAAABnFpcRrUzJsnTdNfX8xn6eDjtYTU1VAtm1Hn9-PhtwZbNL8lWxt1QLWLohvFYcCA53c5Mk14gYwE5sUY_4D_lB7YAk6AcE29ao5z8iSvQLgbwvoBW7hXDTGiYWMUnCsWtsC3yq_h7vBTKdNoBvjM4aHKp2iAJKNwECYcSzwe-sJcUdFDq9Ui4quPNrSNjgIj5Q__rAC67Z_ELyosURn3pISxW03VV-w_RY2eTvFo7Swx3E0GuT_KL4ZNccx0AzoECaiwOOpQVJ3-J_ArUOl2pmJiqXG614GWBYdunQgvsSQA9sMYIwUUs64rpmhsmGLIyD_qO7mCL60voVStR9uUNV5IO8X7qDLpKrCt6ESNL0kt-69pc=');
INSERT INTO connection VALUES(33,'pig_cli_default','pig_cli',NULL,NULL,'default',NULL,NULL,NULL,0,0,NULL);
INSERT INTO connection VALUES(34,'pinot_admin_default','pinot',NULL,'localhost',NULL,NULL,NULL,9000,0,0,NULL);
INSERT INTO connection VALUES(35,'pinot_broker_default','pinot',NULL,'localhost',NULL,NULL,NULL,9000,0,1,'gAAAAABnFpcRh64ZJ2GDPKTilnBNSqTvUVvuc0LCnTtu0gpZHly3-prw8QXwofqF8L2gbk_SVzNRWu-smtilm7JyswoqTAh-j-PGru7d6UntCdl9eeVQaUs3alhRcfKKpT2oSBHI7jzn');
INSERT INTO connection VALUES(36,'postgres_default','postgres',NULL,'postgres','airflow','postgres','gAAAAABnFpcSaI20AUcANApodayU2gNsP4huwXKBb9ZghAVjin90aALDyGv6-ecyZXnSr92XQo-JgYoq6UYi6t3flHmRs8DidQ==',NULL,1,0,NULL);
INSERT INTO connection VALUES(37,'presto_default','presto',NULL,'localhost','hive',NULL,NULL,3400,0,0,NULL);
INSERT INTO connection VALUES(38,'qubole_default','qubole',NULL,'localhost',NULL,NULL,NULL,NULL,0,0,NULL);
INSERT INTO connection VALUES(39,'redis_default','redis',NULL,'redis',NULL,NULL,NULL,6379,0,1,'gAAAAABnFpcSGpJylFv0dU0ZkVFqv22nCeagkl9MMqisJIBAFdy3Fm3TNAjXZo0auoxBJIfINuHT4WmIaS1HPbsUNpDQr_usrA==');
INSERT INTO connection VALUES(40,'redshift_default','redshift',NULL,NULL,NULL,NULL,NULL,NULL,0,1,'gAAAAABnFpcSrCzoG_JIgCf0qOjvtUmnSHcV_rDuQktfrtXrop_aL3q4kUrjwPSyR94dgDd-k2Xy1cXuicNAvpvuAP6N1dzAyWnI-HE3NyLPyeEx4TlFKGvHFVdRj7PhNPjNE3HX_qMJk3NYrBepbdSj_ygjWeoycerw0duYchAtCIMXdG3pcb3JEubLlDGR1emiMqdM1YDgzoWG-qh1yZQsoqBeo5kU4-3OptByQHKyKaW1NHRNXZJrZB1ZdASBRTiagtOyNDi4dKlaRyPIljHWpsyq4RaENQe842TcMRJDo1u7AhrMhFMwfDXYlSiS0tCRfjiAD0Ob');
INSERT INTO connection VALUES(41,'salesforce_default','salesforce',NULL,NULL,NULL,'username','gAAAAABnFpcS8u_fIApx6Dgwt733h9mT8hjkvbBWMXcoq7T7jA6814V402QwZR9qzJiKzG8jnrCE7CkWFFPb8unFBrX9eBP-TA==',NULL,1,1,'gAAAAABnFpcSK6i0uD0_GfoEIidQkeEapySjcqKSKMorkm1tePRLsfyRd75BgRyQd4qhD2Pe5S8JJVQwwBy8yG-AI3T7F1zjue4m5zpxu2FYXZ0mOeWsNmzUmMUtsh2x7MbkOh7PqPkN');
INSERT INTO connection VALUES(42,'segment_default','segment',NULL,NULL,NULL,NULL,NULL,NULL,0,1,'gAAAAABnFpcSYPyWbGTusfHcCCgFF81HB8QvWrdpnvw33_vNSe0b6XW3ZpQ3cqfWzdRLC2eJIkBwbPEufoPhEQ3nTao_FJ9QgmFTGUzAEUa4d-LVaaqHOyyoAZOO3DvwIgmmbcsSSTyP');
INSERT INTO connection VALUES(43,'sftp_default','sftp',NULL,'localhost',NULL,'airflow',NULL,22,0,1,'gAAAAABnFpcSj3VQk1GQEW9g4vSBJoP2wrFkHruGTxPqIUjO8TpykXENlY_6Dzrw0fAGd3YgX666NkS5qFb9kyXZQVaYyHJD6Q_e9Er4eu_IIntoMQzbhjpDZKQyJaCGk_Yg8sxcSK6onp68W6sBNyLCSOwVw8ItxA==');
INSERT INTO connection VALUES(44,'spark_default','spark',NULL,'yarn',NULL,NULL,NULL,NULL,0,1,'gAAAAABnFpcSEyJNWHgt-p_3zwi1gwSU0iPQs7l1oM4XUOftUaUyWw162Wi7ONVb-HfknyLkzg3sTUaIjfPKNqIUD4ZbC4lxzxmC1zE5P9sXLcfEnQEE9rc=');
INSERT INTO connection VALUES(45,'sqlite_default','sqlite',NULL,'/var/folders/zz/zyxvpxvq6csfxvn_n0000000000000/T/sqlite_default.db',NULL,NULL,NULL,NULL,0,0,NULL);
INSERT INTO connection VALUES(46,'sqoop_default','sqoop',NULL,'rdbms',NULL,NULL,NULL,NULL,0,0,NULL);
INSERT INTO connection VALUES(47,'ssh_default','ssh',NULL,'localhost',NULL,NULL,NULL,NULL,0,0,NULL);
INSERT INTO connection VALUES(48,'tableau_default','tableau',NULL,'https://tableau.server.url',NULL,'user','gAAAAABnFpcSS8N9174_WKUB-xC3-xauC03PR3MR3su8sNWcebYVOFVF8BRrG1us33mZcv_XeGoQgkdxKTe5g-Qf5uHUwOf6uw==',NULL,1,1,'gAAAAABnFpcStfA19MJPyL1dgagCQH08c4_3_Ayghpr1HZuavO__aKoQOk5aokqpM1d_-Cj7d8PqTUPY16wPi1AFKivl8LOGEX9lKBpcDp488IKb1phrFUY=');
INSERT INTO connection VALUES(49,'tabular_default','tabular',NULL,'https://api.tabulardata.io/ws/v1',NULL,NULL,NULL,NULL,0,0,NULL);
INSERT INTO connection VALUES(50,'trino_default','trino',NULL,'localhost','hive',NULL,NULL,3400,0,0,NULL);
INSERT INTO connection VALUES(51,'vertica_default','vertica',NULL,'localhost',NULL,NULL,NULL,5433,0,0,NULL);
INSERT INTO connection VALUES(52,'wasb_default','wasb',NULL,NULL,NULL,NULL,NULL,NULL,0,1,'gAAAAABnFpcSfb1GiffFkwKQgTVTj9C2bGy4fcFg86c5c8uNRGIj7dkyke3i0gZRtgPABy3V4pgZFIcl-QrZiwSdXdv1dYEzJgsbpy0ztQ4YseghRPM-8Ug=');
INSERT INTO connection VALUES(53,'webhdfs_default','hdfs',NULL,'localhost',NULL,NULL,NULL,50070,0,0,NULL);
INSERT INTO connection VALUES(54,'yandexcloud_default','yandexcloud',NULL,NULL,'default',NULL,NULL,NULL,0,0,NULL);
CREATE TABLE callback_request (
	id INTEGER NOT NULL, 
	created_at TIMESTAMP NOT NULL, 
	priority_weight INTEGER NOT NULL, 
	callback_data JSON NOT NULL, 
	callback_type VARCHAR(20) NOT NULL, 
	processor_subdir VARCHAR(2000), 
	CONSTRAINT callback_request_pkey PRIMARY KEY (id)
);
CREATE TABLE import_error (
	id INTEGER NOT NULL, 
	timestamp TIMESTAMP, 
	filename VARCHAR(1024), 
	stacktrace TEXT, 
	CONSTRAINT import_error_pkey PRIMARY KEY (id)
);
CREATE TABLE sla_miss (
	task_id VARCHAR(250) NOT NULL, 
	dag_id VARCHAR(250) NOT NULL, 
	execution_date TIMESTAMP NOT NULL, 
	email_sent BOOLEAN, 
	timestamp TIMESTAMP, 
	description TEXT, 
	notification_sent BOOLEAN, 
	CONSTRAINT sla_miss_pkey PRIMARY KEY (task_id, dag_id, execution_date)
);
CREATE TABLE IF NOT EXISTS "trigger" (
	id INTEGER NOT NULL, 
	classpath VARCHAR(1000) NOT NULL, 
	kwargs JSON NOT NULL, 
	created_date TIMESTAMP NOT NULL, 
	triggerer_id INTEGER, 
	CONSTRAINT trigger_pkey PRIMARY KEY (id)
);
CREATE TABLE variable (
	id INTEGER NOT NULL, 
	"key" VARCHAR(250), 
	val TEXT, 
	description TEXT, 
	is_encrypted BOOLEAN, 
	CONSTRAINT variable_pkey PRIMARY KEY (id), 
	CONSTRAINT variable_key_uq UNIQUE ("key")
);
CREATE TABLE job (
	id INTEGER NOT NULL, 
	dag_id VARCHAR(250), 
	state VARCHAR(20), 
	job_type VARCHAR(30), 
	start_date TIMESTAMP, 
	end_date TIMESTAMP, 
	latest_heartbeat TIMESTAMP, 
	executor_class VARCHAR(500), 
	hostname VARCHAR(500), 
	unixname VARCHAR(1000), 
	CONSTRAINT job_pkey PRIMARY KEY (id)
);
INSERT INTO job VALUES(1,NULL,'success','TriggererJob','2024-10-21 18:02:15.217614','2024-10-21 18:08:03.465438','2024-10-21 18:08:00.084883','SequentialExecutor','MacBook-Air-de-Pedro.local','root');
INSERT INTO job VALUES(2,NULL,'failed','SchedulerJob','2024-10-21 18:02:15.276404',NULL,'2024-10-21 18:07:58.384803','SequentialExecutor','MacBook-Air-de-Pedro.local','root');
INSERT INTO job VALUES(3,NULL,'success','TriggererJob','2024-10-21 18:58:20.083589','2024-10-21 19:08:03.594582','2024-10-21 19:07:59.885076','SequentialExecutor','MacBook-Air-de-Pedro.local','root');
INSERT INTO job VALUES(4,NULL,'running','SchedulerJob','2024-10-21 18:58:20.074833',NULL,'2024-10-21 19:07:55.152856','SequentialExecutor','MacBook-Air-de-Pedro.local','root');
CREATE TABLE serialized_dag (
	dag_id VARCHAR(250) NOT NULL, 
	fileloc VARCHAR(2000) NOT NULL, 
	fileloc_hash BIGINT NOT NULL, 
	data JSON, 
	data_compressed BLOB, 
	last_updated TIMESTAMP NOT NULL, 
	dag_hash VARCHAR(32) NOT NULL, 
	processor_subdir VARCHAR(2000), 
	CONSTRAINT serialized_dag_pkey PRIMARY KEY (dag_id)
);
INSERT INTO serialized_dag VALUES('example_dag_basic','/private/var/root/devs/api_wpp/apache_airflows/airflowers/dags/example_dag_basic.py',37343288193572262,'{"__version": 1, "dag": {"start_date": 1672531200.0, "timezone": "UTC", "_default_view": "grid", "_task_group": {"_group_id": null, "prefix_group_id": true, "tooltip": "", "ui_color": "CornflowerBlue", "ui_fgcolor": "#000", "children": {"extract": ["operator", "extract"], "transform": ["operator", "transform"], "load": ["operator", "load"]}, "upstream_group_ids": [], "downstream_group_ids": [], "upstream_task_ids": [], "downstream_task_ids": []}, "_dag_id": "example_dag_basic", "schedule_interval": "@daily", "fileloc": "/private/var/root/devs/api_wpp/apache_airflows/airflowers/dags/example_dag_basic.py", "default_args": {"__var": {"retries": 2}, "__type": "dict"}, "edge_info": {}, "tags": ["example"], "dataset_triggers": [], "catchup": false, "doc_md": "\n    ### Basic ETL Dag\n    This is a simple ETL data pipeline example that demonstrates the use of\n    the TaskFlow API using three simple tasks for extract, transform, and load.\n    For more information on Airflow''s TaskFlow API, reference documentation here:\n    https://airflow.apache.org/docs/apache-airflow/stable/tutorial_taskflow_api.html\n    ", "_processor_dags_folder": "/private/var/root/devs/api_wpp/apache_airflows/airflowers/dags", "tasks": [{"template_fields": ["templates_dict", "op_args", "op_kwargs"], "pool": "default_pool", "ui_color": "#ffefeb", "downstream_task_ids": ["transform"], "ui_fgcolor": "#000", "task_id": "extract", "template_ext": [], "retries": 2, "template_fields_renderers": {"templates_dict": "json", "op_args": "py", "op_kwargs": "py"}, "doc_md": "\n        #### Extract task\n        A simple \"extract\" task to get data ready for the rest of the\n        pipeline. In this case, getting data is simulated by reading from a\n        hardcoded JSON string.\n        ", "_task_type": "_PythonDecoratedOperator", "_task_module": "airflow.decorators.python", "_operator_name": "@task", "_is_empty": false, "op_args": [], "op_kwargs": {}}, {"template_fields": ["templates_dict", "op_args", "op_kwargs"], "pool": "default_pool", "ui_color": "#ffefeb", "downstream_task_ids": ["load"], "ui_fgcolor": "#000", "task_id": "transform", "template_ext": [], "retries": 2, "template_fields_renderers": {"templates_dict": "json", "op_args": "py", "op_kwargs": "py"}, "doc_md": "\n        #### Transform task\n        A simple \"transform\" task which takes in the collection of order data and\n        computes the total order value.\n        ", "_task_type": "_PythonDecoratedOperator", "_task_module": "airflow.decorators.python", "_operator_name": "@task", "_is_empty": false, "op_args": "(XComArg(<Task(_PythonDecoratedOperator): extract>),)", "op_kwargs": {}}, {"template_fields": ["templates_dict", "op_args", "op_kwargs"], "pool": "default_pool", "ui_color": "#ffefeb", "downstream_task_ids": [], "ui_fgcolor": "#000", "task_id": "load", "template_ext": [], "retries": 2, "template_fields_renderers": {"templates_dict": "json", "op_args": "py", "op_kwargs": "py"}, "doc_md": "\n        #### Load task\n        A simple \"load\" task that takes in the result of the \"transform\" task and prints it out,\n        instead of saving it to end user review\n        ", "_task_type": "_PythonDecoratedOperator", "_task_module": "airflow.decorators.python", "_operator_name": "@task", "_is_empty": false, "op_args": "(XComArg(<Task(_PythonDecoratedOperator): transform>, ''total_order_value''),)", "op_kwargs": {}}], "dag_dependencies": [], "params": {}}}',NULL,'2024-10-21 18:58:02.643462','27ddda76b7027fd855eb1aff47549f54',NULL);
CREATE TABLE ab_permission (
	id INTEGER NOT NULL, 
	name VARCHAR(100) NOT NULL, 
	CONSTRAINT ab_permission_pkey PRIMARY KEY (id), 
	CONSTRAINT ab_permission_name_uq UNIQUE (name)
);
INSERT INTO ab_permission VALUES(1,'can_delete');
INSERT INTO ab_permission VALUES(2,'can_edit');
INSERT INTO ab_permission VALUES(3,'can_read');
INSERT INTO ab_permission VALUES(4,'can_create');
INSERT INTO ab_permission VALUES(5,'menu_access');
INSERT INTO ab_permission VALUES(6,'clear');
INSERT INTO ab_permission VALUES(7,'set_failed');
INSERT INTO ab_permission VALUES(8,'set_retry');
INSERT INTO ab_permission VALUES(9,'set_running');
INSERT INTO ab_permission VALUES(10,'set_skipped');
INSERT INTO ab_permission VALUES(11,'set_success');
CREATE TABLE ab_view_menu (
	id INTEGER NOT NULL, 
	name VARCHAR(250) NOT NULL, 
	CONSTRAINT ab_view_menu_pkey PRIMARY KEY (id), 
	CONSTRAINT ab_view_menu_name_uq UNIQUE (name)
);
INSERT INTO ab_view_menu VALUES(1,'DAG:example_dag_basic');
INSERT INTO ab_view_menu VALUES(2,'IndexView');
INSERT INTO ab_view_menu VALUES(3,'UtilView');
INSERT INTO ab_view_menu VALUES(4,'LocaleView');
INSERT INTO ab_view_menu VALUES(5,'Passwords');
INSERT INTO ab_view_menu VALUES(6,'My Password');
INSERT INTO ab_view_menu VALUES(7,'My Profile');
INSERT INTO ab_view_menu VALUES(8,'AuthDBView');
INSERT INTO ab_view_menu VALUES(9,'Users');
INSERT INTO ab_view_menu VALUES(10,'List Users');
INSERT INTO ab_view_menu VALUES(11,'Security');
INSERT INTO ab_view_menu VALUES(12,'Roles');
INSERT INTO ab_view_menu VALUES(13,'List Roles');
INSERT INTO ab_view_menu VALUES(14,'User Stats Chart');
INSERT INTO ab_view_menu VALUES(15,'User''s Statistics');
INSERT INTO ab_view_menu VALUES(16,'Permissions');
INSERT INTO ab_view_menu VALUES(17,'Actions');
INSERT INTO ab_view_menu VALUES(18,'View Menus');
INSERT INTO ab_view_menu VALUES(19,'Resources');
INSERT INTO ab_view_menu VALUES(20,'Permission Views');
INSERT INTO ab_view_menu VALUES(21,'Permission Pairs');
INSERT INTO ab_view_menu VALUES(22,'AutocompleteView');
INSERT INTO ab_view_menu VALUES(23,'Airflow');
INSERT INTO ab_view_menu VALUES(24,'DAG Runs');
INSERT INTO ab_view_menu VALUES(25,'Browse');
INSERT INTO ab_view_menu VALUES(26,'Jobs');
INSERT INTO ab_view_menu VALUES(27,'Audit Logs');
INSERT INTO ab_view_menu VALUES(28,'Variables');
INSERT INTO ab_view_menu VALUES(29,'Admin');
INSERT INTO ab_view_menu VALUES(30,'Task Instances');
INSERT INTO ab_view_menu VALUES(31,'Task Reschedules');
INSERT INTO ab_view_menu VALUES(32,'Triggers');
INSERT INTO ab_view_menu VALUES(33,'Configurations');
INSERT INTO ab_view_menu VALUES(34,'Connections');
INSERT INTO ab_view_menu VALUES(35,'SLA Misses');
INSERT INTO ab_view_menu VALUES(36,'Plugins');
INSERT INTO ab_view_menu VALUES(37,'Providers');
INSERT INTO ab_view_menu VALUES(38,'Pools');
INSERT INTO ab_view_menu VALUES(39,'XComs');
INSERT INTO ab_view_menu VALUES(40,'DagDependenciesView');
INSERT INTO ab_view_menu VALUES(41,'DAG Dependencies');
INSERT INTO ab_view_menu VALUES(42,'RedocView');
INSERT INTO ab_view_menu VALUES(43,'DAGs');
INSERT INTO ab_view_menu VALUES(44,'Datasets');
INSERT INTO ab_view_menu VALUES(45,'Documentation');
INSERT INTO ab_view_menu VALUES(46,'Docs');
INSERT INTO ab_view_menu VALUES(47,'ImportError');
INSERT INTO ab_view_menu VALUES(48,'DAG Code');
INSERT INTO ab_view_menu VALUES(49,'DAG Warnings');
INSERT INTO ab_view_menu VALUES(50,'Task Logs');
INSERT INTO ab_view_menu VALUES(51,'Website');
CREATE TABLE ab_role (
	id INTEGER NOT NULL, 
	name VARCHAR(64) NOT NULL, 
	CONSTRAINT ab_role_pkey PRIMARY KEY (id), 
	CONSTRAINT ab_role_name_uq UNIQUE (name)
);
INSERT INTO ab_role VALUES(1,'Admin');
INSERT INTO ab_role VALUES(2,'Public');
INSERT INTO ab_role VALUES(3,'Viewer');
INSERT INTO ab_role VALUES(4,'User');
INSERT INTO ab_role VALUES(5,'Op');
CREATE TABLE ab_user (
	id INTEGER NOT NULL, 
	first_name VARCHAR(64) NOT NULL, 
	last_name VARCHAR(64) NOT NULL, 
	username VARCHAR(256) COLLATE "NOCASE" NOT NULL, 
	password VARCHAR(256), 
	active BOOLEAN, 
	email VARCHAR(256) NOT NULL, 
	last_login DATETIME, 
	login_count INTEGER, 
	fail_login_count INTEGER, 
	created_on DATETIME, 
	changed_on DATETIME, 
	created_by_fk INTEGER, 
	changed_by_fk INTEGER, 
	CONSTRAINT ab_user_pkey PRIMARY KEY (id), 
	CONSTRAINT ab_user_username_uq UNIQUE (username), 
	CONSTRAINT ab_user_email_uq UNIQUE (email), 
	CONSTRAINT ab_user_created_by_fk_fkey FOREIGN KEY(created_by_fk) REFERENCES ab_user (id), 
	CONSTRAINT ab_user_changed_by_fk_fkey FOREIGN KEY(changed_by_fk) REFERENCES ab_user (id)
);
INSERT INTO ab_user VALUES(1,'Admin','User','admin','pbkdf2:sha256:260000$dVzWt5UCyHCIFw4F$6374593ab78163c3a47da2ab715ae042ae4ad112e389d18279f7db35904ee561',1,'admin@example.com',NULL,NULL,NULL,'2024-10-21 15:02:06.355272','2024-10-21 15:02:06.355284',NULL,NULL);
CREATE TABLE ab_register_user (
	id INTEGER NOT NULL, 
	first_name VARCHAR(64) NOT NULL, 
	last_name VARCHAR(64) NOT NULL, 
	username VARCHAR(256) COLLATE "NOCASE" NOT NULL, 
	password VARCHAR(256), 
	email VARCHAR(256) NOT NULL, 
	registration_date DATETIME, 
	registration_hash VARCHAR(256), 
	CONSTRAINT ab_register_user_pkey PRIMARY KEY (id), 
	CONSTRAINT ab_register_user_username_uq UNIQUE (username)
);
CREATE TABLE dag_schedule_dataset_reference (
	dataset_id INTEGER NOT NULL, 
	dag_id VARCHAR(250) NOT NULL, 
	created_at TIMESTAMP NOT NULL, 
	updated_at TIMESTAMP NOT NULL, 
	CONSTRAINT dsdr_pkey PRIMARY KEY (dataset_id, dag_id), 
	CONSTRAINT dsdr_dataset_fkey FOREIGN KEY(dataset_id) REFERENCES dataset (id) ON DELETE CASCADE, 
	CONSTRAINT dsdr_dag_id_fkey FOREIGN KEY(dag_id) REFERENCES dag (dag_id) ON DELETE CASCADE
);
CREATE TABLE task_outlet_dataset_reference (
	dataset_id INTEGER NOT NULL, 
	dag_id VARCHAR(250) NOT NULL, 
	task_id VARCHAR(250) NOT NULL, 
	created_at TIMESTAMP NOT NULL, 
	updated_at TIMESTAMP NOT NULL, 
	CONSTRAINT todr_pkey PRIMARY KEY (dataset_id, dag_id, task_id), 
	CONSTRAINT todr_dataset_fkey FOREIGN KEY(dataset_id) REFERENCES dataset (id) ON DELETE CASCADE, 
	CONSTRAINT todr_dag_id_fkey FOREIGN KEY(dag_id) REFERENCES dag (dag_id) ON DELETE CASCADE
);
CREATE TABLE dataset_dag_run_queue (
	dataset_id INTEGER NOT NULL, 
	target_dag_id VARCHAR(250) NOT NULL, 
	created_at TIMESTAMP NOT NULL, 
	CONSTRAINT datasetdagrunqueue_pkey PRIMARY KEY (dataset_id, target_dag_id), 
	CONSTRAINT ddrq_dataset_fkey FOREIGN KEY(dataset_id) REFERENCES dataset (id) ON DELETE CASCADE, 
	CONSTRAINT ddrq_dag_fkey FOREIGN KEY(target_dag_id) REFERENCES dag (dag_id) ON DELETE CASCADE
);
CREATE TABLE dag_run (
	id INTEGER NOT NULL, 
	dag_id VARCHAR(250) NOT NULL, 
	queued_at TIMESTAMP, 
	execution_date TIMESTAMP NOT NULL, 
	start_date TIMESTAMP, 
	end_date TIMESTAMP, 
	state VARCHAR(50), 
	run_id VARCHAR(250) NOT NULL, 
	creating_job_id INTEGER, 
	external_trigger BOOLEAN, 
	run_type VARCHAR(50) NOT NULL, 
	conf BLOB, 
	data_interval_start TIMESTAMP, 
	data_interval_end TIMESTAMP, 
	last_scheduling_decision TIMESTAMP, 
	dag_hash VARCHAR(32), 
	log_template_id INTEGER, 
	CONSTRAINT dag_run_pkey PRIMARY KEY (id), 
	CONSTRAINT dag_run_dag_id_execution_date_key UNIQUE (dag_id, execution_date), 
	CONSTRAINT dag_run_dag_id_run_id_key UNIQUE (dag_id, run_id), 
	CONSTRAINT task_instance_log_template_id_fkey FOREIGN KEY(log_template_id) REFERENCES log_template (id) ON DELETE NO ACTION
);
CREATE TABLE dag_tag (
	name VARCHAR(100) NOT NULL, 
	dag_id VARCHAR(250) NOT NULL, 
	CONSTRAINT dag_tag_pkey PRIMARY KEY (name, dag_id), 
	CONSTRAINT dag_tag_dag_id_fkey FOREIGN KEY(dag_id) REFERENCES dag (dag_id) ON DELETE CASCADE
);
INSERT INTO dag_tag VALUES('example','example_dag_basic');
CREATE TABLE dag_owner_attributes (
	dag_id VARCHAR(250) NOT NULL, 
	owner VARCHAR(500) NOT NULL, 
	link VARCHAR(500) NOT NULL, 
	CONSTRAINT dag_owner_attributes_pkey PRIMARY KEY (dag_id, owner), 
	CONSTRAINT "dag.dag_id" FOREIGN KEY(dag_id) REFERENCES dag (dag_id) ON DELETE CASCADE
);
CREATE TABLE dag_warning (
	dag_id VARCHAR(250) NOT NULL, 
	warning_type VARCHAR(50) NOT NULL, 
	message TEXT NOT NULL, 
	timestamp TIMESTAMP NOT NULL, 
	CONSTRAINT dag_warning_pkey PRIMARY KEY (dag_id, warning_type), 
	CONSTRAINT dcw_dag_id_fkey FOREIGN KEY(dag_id) REFERENCES dag (dag_id) ON DELETE CASCADE
);
CREATE TABLE ab_permission_view (
	id INTEGER NOT NULL, 
	permission_id INTEGER, 
	view_menu_id INTEGER, 
	CONSTRAINT ab_permission_view_pkey PRIMARY KEY (id), 
	CONSTRAINT ab_permission_view_permission_id_view_menu_id_uq UNIQUE (permission_id, view_menu_id), 
	CONSTRAINT ab_permission_view_permission_id_fkey FOREIGN KEY(permission_id) REFERENCES ab_permission (id), 
	CONSTRAINT ab_permission_view_view_menu_id_fkey FOREIGN KEY(view_menu_id) REFERENCES ab_view_menu (id)
);
INSERT INTO ab_permission_view VALUES(1,1,1);
INSERT INTO ab_permission_view VALUES(2,2,1);
INSERT INTO ab_permission_view VALUES(3,3,1);
INSERT INTO ab_permission_view VALUES(4,2,5);
INSERT INTO ab_permission_view VALUES(5,3,5);
INSERT INTO ab_permission_view VALUES(6,2,6);
INSERT INTO ab_permission_view VALUES(7,3,6);
INSERT INTO ab_permission_view VALUES(8,2,7);
INSERT INTO ab_permission_view VALUES(9,3,7);
INSERT INTO ab_permission_view VALUES(10,4,9);
INSERT INTO ab_permission_view VALUES(11,3,9);
INSERT INTO ab_permission_view VALUES(12,2,9);
INSERT INTO ab_permission_view VALUES(13,1,9);
INSERT INTO ab_permission_view VALUES(14,5,10);
INSERT INTO ab_permission_view VALUES(15,5,11);
INSERT INTO ab_permission_view VALUES(16,4,12);
INSERT INTO ab_permission_view VALUES(17,3,12);
INSERT INTO ab_permission_view VALUES(18,2,12);
INSERT INTO ab_permission_view VALUES(19,1,12);
INSERT INTO ab_permission_view VALUES(20,5,13);
INSERT INTO ab_permission_view VALUES(21,3,14);
INSERT INTO ab_permission_view VALUES(22,5,15);
INSERT INTO ab_permission_view VALUES(23,3,16);
INSERT INTO ab_permission_view VALUES(24,5,17);
INSERT INTO ab_permission_view VALUES(25,3,18);
INSERT INTO ab_permission_view VALUES(26,5,19);
INSERT INTO ab_permission_view VALUES(27,3,20);
INSERT INTO ab_permission_view VALUES(28,5,21);
INSERT INTO ab_permission_view VALUES(29,4,24);
INSERT INTO ab_permission_view VALUES(30,3,24);
INSERT INTO ab_permission_view VALUES(31,2,24);
INSERT INTO ab_permission_view VALUES(32,1,24);
INSERT INTO ab_permission_view VALUES(33,5,24);
INSERT INTO ab_permission_view VALUES(34,5,25);
INSERT INTO ab_permission_view VALUES(35,3,26);
INSERT INTO ab_permission_view VALUES(36,5,26);
INSERT INTO ab_permission_view VALUES(37,3,27);
INSERT INTO ab_permission_view VALUES(38,5,27);
INSERT INTO ab_permission_view VALUES(39,4,28);
INSERT INTO ab_permission_view VALUES(40,3,28);
INSERT INTO ab_permission_view VALUES(41,2,28);
INSERT INTO ab_permission_view VALUES(42,1,28);
INSERT INTO ab_permission_view VALUES(43,5,28);
INSERT INTO ab_permission_view VALUES(44,5,29);
INSERT INTO ab_permission_view VALUES(45,4,30);
INSERT INTO ab_permission_view VALUES(46,3,30);
INSERT INTO ab_permission_view VALUES(47,2,30);
INSERT INTO ab_permission_view VALUES(48,1,30);
INSERT INTO ab_permission_view VALUES(49,5,30);
INSERT INTO ab_permission_view VALUES(50,6,30);
INSERT INTO ab_permission_view VALUES(51,7,30);
INSERT INTO ab_permission_view VALUES(52,8,30);
INSERT INTO ab_permission_view VALUES(53,9,30);
INSERT INTO ab_permission_view VALUES(54,10,30);
INSERT INTO ab_permission_view VALUES(55,11,30);
INSERT INTO ab_permission_view VALUES(56,3,31);
INSERT INTO ab_permission_view VALUES(57,5,31);
INSERT INTO ab_permission_view VALUES(58,3,32);
INSERT INTO ab_permission_view VALUES(59,5,32);
INSERT INTO ab_permission_view VALUES(60,3,33);
INSERT INTO ab_permission_view VALUES(61,5,33);
INSERT INTO ab_permission_view VALUES(62,4,34);
INSERT INTO ab_permission_view VALUES(63,3,34);
INSERT INTO ab_permission_view VALUES(64,2,34);
INSERT INTO ab_permission_view VALUES(65,1,34);
INSERT INTO ab_permission_view VALUES(66,5,34);
INSERT INTO ab_permission_view VALUES(67,3,35);
INSERT INTO ab_permission_view VALUES(68,5,35);
INSERT INTO ab_permission_view VALUES(69,3,36);
INSERT INTO ab_permission_view VALUES(70,5,36);
INSERT INTO ab_permission_view VALUES(71,3,37);
INSERT INTO ab_permission_view VALUES(72,5,37);
INSERT INTO ab_permission_view VALUES(73,4,38);
INSERT INTO ab_permission_view VALUES(74,3,38);
INSERT INTO ab_permission_view VALUES(75,2,38);
INSERT INTO ab_permission_view VALUES(76,1,38);
INSERT INTO ab_permission_view VALUES(77,5,38);
INSERT INTO ab_permission_view VALUES(78,4,39);
INSERT INTO ab_permission_view VALUES(79,3,39);
INSERT INTO ab_permission_view VALUES(80,1,39);
INSERT INTO ab_permission_view VALUES(81,5,39);
INSERT INTO ab_permission_view VALUES(82,5,41);
INSERT INTO ab_permission_view VALUES(83,5,43);
INSERT INTO ab_permission_view VALUES(84,5,44);
INSERT INTO ab_permission_view VALUES(85,5,45);
INSERT INTO ab_permission_view VALUES(86,5,46);
INSERT INTO ab_permission_view VALUES(87,3,43);
INSERT INTO ab_permission_view VALUES(88,2,43);
INSERT INTO ab_permission_view VALUES(89,1,43);
INSERT INTO ab_permission_view VALUES(90,3,44);
INSERT INTO ab_permission_view VALUES(91,3,47);
INSERT INTO ab_permission_view VALUES(92,3,48);
INSERT INTO ab_permission_view VALUES(93,3,49);
INSERT INTO ab_permission_view VALUES(94,3,41);
INSERT INTO ab_permission_view VALUES(95,3,50);
INSERT INTO ab_permission_view VALUES(96,3,51);
CREATE TABLE ab_user_role (
	id INTEGER NOT NULL, 
	user_id INTEGER, 
	role_id INTEGER, 
	CONSTRAINT ab_user_role_pkey PRIMARY KEY (id), 
	CONSTRAINT ab_user_role_user_id_role_id_uq UNIQUE (user_id, role_id), 
	CONSTRAINT ab_user_role_user_id_fkey FOREIGN KEY(user_id) REFERENCES ab_user (id), 
	CONSTRAINT ab_user_role_role_id_fkey FOREIGN KEY(role_id) REFERENCES ab_role (id)
);
INSERT INTO ab_user_role VALUES(1,1,1);
CREATE TABLE dagrun_dataset_event (
	dag_run_id INTEGER NOT NULL, 
	event_id INTEGER NOT NULL, 
	CONSTRAINT dagrun_dataset_event_pkey PRIMARY KEY (dag_run_id, event_id), 
	CONSTRAINT dagrun_dataset_event_dag_run_id_fkey FOREIGN KEY(dag_run_id) REFERENCES dag_run (id) ON DELETE CASCADE, 
	CONSTRAINT dagrun_dataset_event_event_id_fkey FOREIGN KEY(event_id) REFERENCES dataset_event (id) ON DELETE CASCADE
);
CREATE TABLE task_instance (
	task_id VARCHAR(250) NOT NULL, 
	dag_id VARCHAR(250) NOT NULL, 
	run_id VARCHAR(250) NOT NULL, 
	map_index INTEGER DEFAULT -1 NOT NULL, 
	start_date TIMESTAMP, 
	end_date TIMESTAMP, 
	duration FLOAT, 
	state VARCHAR(20), 
	try_number INTEGER, 
	max_tries INTEGER DEFAULT -1, 
	hostname VARCHAR(1000), 
	unixname VARCHAR(1000), 
	job_id INTEGER, 
	pool VARCHAR(256) NOT NULL, 
	pool_slots INTEGER NOT NULL, 
	queue VARCHAR(256), 
	priority_weight INTEGER, 
	operator VARCHAR(1000), 
	queued_dttm TIMESTAMP, 
	queued_by_job_id INTEGER, 
	pid INTEGER, 
	executor_config BLOB, 
	external_executor_id VARCHAR(250), 
	trigger_id INTEGER, 
	trigger_timeout DATETIME, 
	next_method VARCHAR(1000), 
	next_kwargs JSON, 
	CONSTRAINT task_instance_pkey PRIMARY KEY (dag_id, task_id, run_id, map_index), 
	CONSTRAINT task_instance_trigger_id_fkey FOREIGN KEY(trigger_id) REFERENCES "trigger" (id) ON DELETE CASCADE, 
	CONSTRAINT task_instance_dag_run_fkey FOREIGN KEY(dag_id, run_id) REFERENCES dag_run (dag_id, run_id) ON DELETE CASCADE
);
CREATE TABLE ab_permission_view_role (
	id INTEGER NOT NULL, 
	permission_view_id INTEGER, 
	role_id INTEGER, 
	CONSTRAINT ab_permission_view_role_pkey PRIMARY KEY (id), 
	CONSTRAINT ab_permission_view_role_permission_view_id_role_id_uq UNIQUE (permission_view_id, role_id), 
	CONSTRAINT ab_permission_view_role_permission_view_id_fkey FOREIGN KEY(permission_view_id) REFERENCES ab_permission_view (id), 
	CONSTRAINT ab_permission_view_role_role_id_fkey FOREIGN KEY(role_id) REFERENCES ab_role (id)
);
INSERT INTO ab_permission_view_role VALUES(1,4,1);
INSERT INTO ab_permission_view_role VALUES(2,5,1);
INSERT INTO ab_permission_view_role VALUES(3,6,1);
INSERT INTO ab_permission_view_role VALUES(4,7,1);
INSERT INTO ab_permission_view_role VALUES(5,8,1);
INSERT INTO ab_permission_view_role VALUES(6,9,1);
INSERT INTO ab_permission_view_role VALUES(7,10,1);
INSERT INTO ab_permission_view_role VALUES(8,11,1);
INSERT INTO ab_permission_view_role VALUES(9,12,1);
INSERT INTO ab_permission_view_role VALUES(10,13,1);
INSERT INTO ab_permission_view_role VALUES(11,14,1);
INSERT INTO ab_permission_view_role VALUES(12,15,1);
INSERT INTO ab_permission_view_role VALUES(13,16,1);
INSERT INTO ab_permission_view_role VALUES(14,17,1);
INSERT INTO ab_permission_view_role VALUES(15,18,1);
INSERT INTO ab_permission_view_role VALUES(16,19,1);
INSERT INTO ab_permission_view_role VALUES(17,20,1);
INSERT INTO ab_permission_view_role VALUES(18,21,1);
INSERT INTO ab_permission_view_role VALUES(19,22,1);
INSERT INTO ab_permission_view_role VALUES(20,23,1);
INSERT INTO ab_permission_view_role VALUES(21,24,1);
INSERT INTO ab_permission_view_role VALUES(22,25,1);
INSERT INTO ab_permission_view_role VALUES(23,26,1);
INSERT INTO ab_permission_view_role VALUES(24,27,1);
INSERT INTO ab_permission_view_role VALUES(25,28,1);
INSERT INTO ab_permission_view_role VALUES(26,29,1);
INSERT INTO ab_permission_view_role VALUES(27,30,1);
INSERT INTO ab_permission_view_role VALUES(28,31,1);
INSERT INTO ab_permission_view_role VALUES(29,32,1);
INSERT INTO ab_permission_view_role VALUES(30,33,1);
INSERT INTO ab_permission_view_role VALUES(31,34,1);
INSERT INTO ab_permission_view_role VALUES(32,35,1);
INSERT INTO ab_permission_view_role VALUES(33,36,1);
INSERT INTO ab_permission_view_role VALUES(34,37,1);
INSERT INTO ab_permission_view_role VALUES(35,38,1);
INSERT INTO ab_permission_view_role VALUES(36,39,1);
INSERT INTO ab_permission_view_role VALUES(37,40,1);
INSERT INTO ab_permission_view_role VALUES(38,41,1);
INSERT INTO ab_permission_view_role VALUES(39,42,1);
INSERT INTO ab_permission_view_role VALUES(40,43,1);
INSERT INTO ab_permission_view_role VALUES(41,44,1);
INSERT INTO ab_permission_view_role VALUES(42,45,1);
INSERT INTO ab_permission_view_role VALUES(43,46,1);
INSERT INTO ab_permission_view_role VALUES(44,47,1);
INSERT INTO ab_permission_view_role VALUES(45,48,1);
INSERT INTO ab_permission_view_role VALUES(46,49,1);
INSERT INTO ab_permission_view_role VALUES(47,50,1);
INSERT INTO ab_permission_view_role VALUES(48,51,1);
INSERT INTO ab_permission_view_role VALUES(49,52,1);
INSERT INTO ab_permission_view_role VALUES(50,53,1);
INSERT INTO ab_permission_view_role VALUES(51,54,1);
INSERT INTO ab_permission_view_role VALUES(52,55,1);
INSERT INTO ab_permission_view_role VALUES(53,56,1);
INSERT INTO ab_permission_view_role VALUES(54,57,1);
INSERT INTO ab_permission_view_role VALUES(55,58,1);
INSERT INTO ab_permission_view_role VALUES(56,59,1);
INSERT INTO ab_permission_view_role VALUES(57,60,1);
INSERT INTO ab_permission_view_role VALUES(58,61,1);
INSERT INTO ab_permission_view_role VALUES(59,62,1);
INSERT INTO ab_permission_view_role VALUES(60,63,1);
INSERT INTO ab_permission_view_role VALUES(61,64,1);
INSERT INTO ab_permission_view_role VALUES(62,65,1);
INSERT INTO ab_permission_view_role VALUES(63,66,1);
INSERT INTO ab_permission_view_role VALUES(64,67,1);
INSERT INTO ab_permission_view_role VALUES(65,68,1);
INSERT INTO ab_permission_view_role VALUES(66,69,1);
INSERT INTO ab_permission_view_role VALUES(67,70,1);
INSERT INTO ab_permission_view_role VALUES(68,71,1);
INSERT INTO ab_permission_view_role VALUES(69,72,1);
INSERT INTO ab_permission_view_role VALUES(70,73,1);
INSERT INTO ab_permission_view_role VALUES(71,74,1);
INSERT INTO ab_permission_view_role VALUES(72,75,1);
INSERT INTO ab_permission_view_role VALUES(73,76,1);
INSERT INTO ab_permission_view_role VALUES(74,77,1);
INSERT INTO ab_permission_view_role VALUES(75,78,1);
INSERT INTO ab_permission_view_role VALUES(76,79,1);
INSERT INTO ab_permission_view_role VALUES(77,80,1);
INSERT INTO ab_permission_view_role VALUES(78,81,1);
INSERT INTO ab_permission_view_role VALUES(79,82,1);
INSERT INTO ab_permission_view_role VALUES(80,83,1);
INSERT INTO ab_permission_view_role VALUES(81,84,1);
INSERT INTO ab_permission_view_role VALUES(82,85,1);
INSERT INTO ab_permission_view_role VALUES(83,86,1);
INSERT INTO ab_permission_view_role VALUES(84,37,3);
INSERT INTO ab_permission_view_role VALUES(85,87,3);
INSERT INTO ab_permission_view_role VALUES(86,94,3);
INSERT INTO ab_permission_view_role VALUES(87,92,3);
INSERT INTO ab_permission_view_role VALUES(88,30,3);
INSERT INTO ab_permission_view_role VALUES(89,90,3);
INSERT INTO ab_permission_view_role VALUES(90,91,3);
INSERT INTO ab_permission_view_role VALUES(91,93,3);
INSERT INTO ab_permission_view_role VALUES(92,35,3);
INSERT INTO ab_permission_view_role VALUES(93,7,3);
INSERT INTO ab_permission_view_role VALUES(94,6,3);
INSERT INTO ab_permission_view_role VALUES(95,9,3);
INSERT INTO ab_permission_view_role VALUES(96,8,3);
INSERT INTO ab_permission_view_role VALUES(97,69,3);
INSERT INTO ab_permission_view_role VALUES(98,67,3);
INSERT INTO ab_permission_view_role VALUES(99,46,3);
INSERT INTO ab_permission_view_role VALUES(100,95,3);
INSERT INTO ab_permission_view_role VALUES(101,79,3);
INSERT INTO ab_permission_view_role VALUES(102,96,3);
INSERT INTO ab_permission_view_role VALUES(103,34,3);
INSERT INTO ab_permission_view_role VALUES(104,83,3);
INSERT INTO ab_permission_view_role VALUES(105,82,3);
INSERT INTO ab_permission_view_role VALUES(106,33,3);
INSERT INTO ab_permission_view_role VALUES(107,84,3);
INSERT INTO ab_permission_view_role VALUES(108,85,3);
INSERT INTO ab_permission_view_role VALUES(109,86,3);
INSERT INTO ab_permission_view_role VALUES(110,36,3);
INSERT INTO ab_permission_view_role VALUES(111,38,3);
INSERT INTO ab_permission_view_role VALUES(112,70,3);
INSERT INTO ab_permission_view_role VALUES(113,68,3);
INSERT INTO ab_permission_view_role VALUES(114,49,3);
INSERT INTO ab_permission_view_role VALUES(115,37,4);
INSERT INTO ab_permission_view_role VALUES(116,87,4);
INSERT INTO ab_permission_view_role VALUES(117,94,4);
INSERT INTO ab_permission_view_role VALUES(118,92,4);
INSERT INTO ab_permission_view_role VALUES(119,30,4);
INSERT INTO ab_permission_view_role VALUES(120,90,4);
INSERT INTO ab_permission_view_role VALUES(121,91,4);
INSERT INTO ab_permission_view_role VALUES(122,93,4);
INSERT INTO ab_permission_view_role VALUES(123,35,4);
INSERT INTO ab_permission_view_role VALUES(124,7,4);
INSERT INTO ab_permission_view_role VALUES(125,6,4);
INSERT INTO ab_permission_view_role VALUES(126,9,4);
INSERT INTO ab_permission_view_role VALUES(127,8,4);
INSERT INTO ab_permission_view_role VALUES(128,69,4);
INSERT INTO ab_permission_view_role VALUES(129,67,4);
INSERT INTO ab_permission_view_role VALUES(130,46,4);
INSERT INTO ab_permission_view_role VALUES(131,95,4);
INSERT INTO ab_permission_view_role VALUES(132,79,4);
INSERT INTO ab_permission_view_role VALUES(133,96,4);
INSERT INTO ab_permission_view_role VALUES(134,34,4);
INSERT INTO ab_permission_view_role VALUES(135,83,4);
INSERT INTO ab_permission_view_role VALUES(136,82,4);
INSERT INTO ab_permission_view_role VALUES(137,33,4);
INSERT INTO ab_permission_view_role VALUES(138,84,4);
INSERT INTO ab_permission_view_role VALUES(139,85,4);
INSERT INTO ab_permission_view_role VALUES(140,86,4);
INSERT INTO ab_permission_view_role VALUES(141,36,4);
INSERT INTO ab_permission_view_role VALUES(142,38,4);
INSERT INTO ab_permission_view_role VALUES(143,70,4);
INSERT INTO ab_permission_view_role VALUES(144,68,4);
INSERT INTO ab_permission_view_role VALUES(145,49,4);
INSERT INTO ab_permission_view_role VALUES(146,88,4);
INSERT INTO ab_permission_view_role VALUES(147,89,4);
INSERT INTO ab_permission_view_role VALUES(148,45,4);
INSERT INTO ab_permission_view_role VALUES(149,47,4);
INSERT INTO ab_permission_view_role VALUES(150,48,4);
INSERT INTO ab_permission_view_role VALUES(151,29,4);
INSERT INTO ab_permission_view_role VALUES(152,31,4);
INSERT INTO ab_permission_view_role VALUES(153,32,4);
INSERT INTO ab_permission_view_role VALUES(154,37,5);
INSERT INTO ab_permission_view_role VALUES(155,87,5);
INSERT INTO ab_permission_view_role VALUES(156,94,5);
INSERT INTO ab_permission_view_role VALUES(157,92,5);
INSERT INTO ab_permission_view_role VALUES(158,30,5);
INSERT INTO ab_permission_view_role VALUES(159,90,5);
INSERT INTO ab_permission_view_role VALUES(160,91,5);
INSERT INTO ab_permission_view_role VALUES(161,93,5);
INSERT INTO ab_permission_view_role VALUES(162,35,5);
INSERT INTO ab_permission_view_role VALUES(163,7,5);
INSERT INTO ab_permission_view_role VALUES(164,6,5);
INSERT INTO ab_permission_view_role VALUES(165,9,5);
INSERT INTO ab_permission_view_role VALUES(166,8,5);
INSERT INTO ab_permission_view_role VALUES(167,69,5);
INSERT INTO ab_permission_view_role VALUES(168,67,5);
INSERT INTO ab_permission_view_role VALUES(169,46,5);
INSERT INTO ab_permission_view_role VALUES(170,95,5);
INSERT INTO ab_permission_view_role VALUES(171,79,5);
INSERT INTO ab_permission_view_role VALUES(172,96,5);
INSERT INTO ab_permission_view_role VALUES(173,34,5);
INSERT INTO ab_permission_view_role VALUES(174,83,5);
INSERT INTO ab_permission_view_role VALUES(175,82,5);
INSERT INTO ab_permission_view_role VALUES(176,33,5);
INSERT INTO ab_permission_view_role VALUES(177,84,5);
INSERT INTO ab_permission_view_role VALUES(178,85,5);
INSERT INTO ab_permission_view_role VALUES(179,86,5);
INSERT INTO ab_permission_view_role VALUES(180,36,5);
INSERT INTO ab_permission_view_role VALUES(181,38,5);
INSERT INTO ab_permission_view_role VALUES(182,70,5);
INSERT INTO ab_permission_view_role VALUES(183,68,5);
INSERT INTO ab_permission_view_role VALUES(184,49,5);
INSERT INTO ab_permission_view_role VALUES(185,88,5);
INSERT INTO ab_permission_view_role VALUES(186,89,5);
INSERT INTO ab_permission_view_role VALUES(187,45,5);
INSERT INTO ab_permission_view_role VALUES(188,47,5);
INSERT INTO ab_permission_view_role VALUES(189,48,5);
INSERT INTO ab_permission_view_role VALUES(190,29,5);
INSERT INTO ab_permission_view_role VALUES(191,31,5);
INSERT INTO ab_permission_view_role VALUES(192,32,5);
INSERT INTO ab_permission_view_role VALUES(193,60,5);
INSERT INTO ab_permission_view_role VALUES(194,44,5);
INSERT INTO ab_permission_view_role VALUES(195,61,5);
INSERT INTO ab_permission_view_role VALUES(196,66,5);
INSERT INTO ab_permission_view_role VALUES(197,77,5);
INSERT INTO ab_permission_view_role VALUES(198,43,5);
INSERT INTO ab_permission_view_role VALUES(199,81,5);
INSERT INTO ab_permission_view_role VALUES(200,62,5);
INSERT INTO ab_permission_view_role VALUES(201,63,5);
INSERT INTO ab_permission_view_role VALUES(202,64,5);
INSERT INTO ab_permission_view_role VALUES(203,65,5);
INSERT INTO ab_permission_view_role VALUES(204,73,5);
INSERT INTO ab_permission_view_role VALUES(205,74,5);
INSERT INTO ab_permission_view_role VALUES(206,75,5);
INSERT INTO ab_permission_view_role VALUES(207,76,5);
INSERT INTO ab_permission_view_role VALUES(208,71,5);
INSERT INTO ab_permission_view_role VALUES(209,39,5);
INSERT INTO ab_permission_view_role VALUES(210,40,5);
INSERT INTO ab_permission_view_role VALUES(211,41,5);
INSERT INTO ab_permission_view_role VALUES(212,42,5);
INSERT INTO ab_permission_view_role VALUES(213,80,5);
INSERT INTO ab_permission_view_role VALUES(214,87,1);
INSERT INTO ab_permission_view_role VALUES(215,94,1);
INSERT INTO ab_permission_view_role VALUES(216,92,1);
INSERT INTO ab_permission_view_role VALUES(217,90,1);
INSERT INTO ab_permission_view_role VALUES(218,91,1);
INSERT INTO ab_permission_view_role VALUES(219,93,1);
INSERT INTO ab_permission_view_role VALUES(220,95,1);
INSERT INTO ab_permission_view_role VALUES(221,96,1);
INSERT INTO ab_permission_view_role VALUES(222,88,1);
INSERT INTO ab_permission_view_role VALUES(223,89,1);
CREATE TABLE task_fail (
	id INTEGER NOT NULL, 
	task_id VARCHAR(250) NOT NULL, 
	dag_id VARCHAR(250) NOT NULL, 
	run_id VARCHAR(250) NOT NULL, 
	map_index INTEGER DEFAULT -1 NOT NULL, 
	start_date TIMESTAMP, 
	end_date TIMESTAMP, 
	duration INTEGER, 
	CONSTRAINT task_fail_pkey PRIMARY KEY (id), 
	CONSTRAINT task_fail_ti_fkey FOREIGN KEY(dag_id, task_id, run_id, map_index) REFERENCES task_instance (dag_id, task_id, run_id, map_index) ON DELETE CASCADE
);
CREATE TABLE task_map (
	dag_id VARCHAR(250) NOT NULL, 
	task_id VARCHAR(250) NOT NULL, 
	run_id VARCHAR(250) NOT NULL, 
	map_index INTEGER NOT NULL, 
	length INTEGER NOT NULL, 
	keys JSON, 
	CONSTRAINT task_map_pkey PRIMARY KEY (dag_id, task_id, run_id, map_index), 
	CONSTRAINT ck_task_map_task_map_length_not_negative CHECK (length >= 0), 
	CONSTRAINT task_map_task_instance_fkey FOREIGN KEY(dag_id, task_id, run_id, map_index) REFERENCES task_instance (dag_id, task_id, run_id, map_index) ON DELETE CASCADE
);
CREATE TABLE task_reschedule (
	id INTEGER NOT NULL, 
	task_id VARCHAR(250) NOT NULL, 
	dag_id VARCHAR(250) NOT NULL, 
	run_id VARCHAR(250) NOT NULL, 
	map_index INTEGER DEFAULT -1 NOT NULL, 
	try_number INTEGER NOT NULL, 
	start_date TIMESTAMP NOT NULL, 
	end_date TIMESTAMP NOT NULL, 
	duration INTEGER NOT NULL, 
	reschedule_date TIMESTAMP NOT NULL, 
	CONSTRAINT task_reschedule_pkey PRIMARY KEY (id), 
	CONSTRAINT task_reschedule_ti_fkey FOREIGN KEY(dag_id, task_id, run_id, map_index) REFERENCES task_instance (dag_id, task_id, run_id, map_index) ON DELETE CASCADE, 
	CONSTRAINT task_reschedule_dr_fkey FOREIGN KEY(dag_id, run_id) REFERENCES dag_run (dag_id, run_id) ON DELETE CASCADE
);
CREATE TABLE xcom (
	dag_run_id INTEGER NOT NULL, 
	task_id VARCHAR(250) NOT NULL, 
	map_index INTEGER DEFAULT -1 NOT NULL, 
	"key" VARCHAR(512) NOT NULL, 
	dag_id VARCHAR(250) NOT NULL, 
	run_id VARCHAR(250) NOT NULL, 
	value BLOB, 
	timestamp TIMESTAMP NOT NULL, 
	CONSTRAINT xcom_pkey PRIMARY KEY (dag_run_id, task_id, map_index, "key"), 
	CONSTRAINT xcom_task_instance_fkey FOREIGN KEY(dag_id, task_id, run_id, map_index) REFERENCES task_instance (dag_id, task_id, run_id, map_index) ON DELETE CASCADE
);
CREATE TABLE rendered_task_instance_fields (
	dag_id VARCHAR(250) NOT NULL, 
	task_id VARCHAR(250) NOT NULL, 
	run_id VARCHAR(250) NOT NULL, 
	map_index INTEGER DEFAULT -1 NOT NULL, 
	rendered_fields JSON NOT NULL, 
	k8s_pod_yaml JSON, 
	CONSTRAINT rendered_task_instance_fields_pkey PRIMARY KEY (dag_id, task_id, run_id, map_index), 
	CONSTRAINT rtif_ti_fkey FOREIGN KEY(dag_id, task_id, run_id, map_index) REFERENCES task_instance (dag_id, task_id, run_id, map_index) ON DELETE CASCADE
);
CREATE TABLE session (
	id INTEGER NOT NULL, 
	session_id VARCHAR(255), 
	data BLOB, 
	expiry DATETIME, 
	PRIMARY KEY (id), 
	UNIQUE (session_id)
);
INSERT INTO session VALUES(1,'0c640f87-08ce-44a3-8b8c-4f0f5dbb1f6f',X'80049563000000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894898c0a637372665f746f6b656e948c2839623162343033366430343435666338346432353461353836326466653264366165356564323334948c066c6f63616c65948c02656e94752e','2024-11-20 19:58:28.801016');
INSERT INTO session VALUES(2,'429ad07e-e1eb-4600-ab4c-c2da4c4b1176',X'8004951d020000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894888c0a637372665f746f6b656e948c2839623162343033366430343435666338346432353461353836326466653264366165356564323334948c066c6f63616c65948c02656e948c085f757365725f6964944b018c035f6964948c803338653566323766613463623333303964326463626336376537313463363466343334386665323431373730646139376130303761646133353235376233336238643064636334313131663335353039323533336565353161383364643339653637366336303536383265333234393263666533626438646465353434653665948c116461675f7374617475735f66696c746572948c03616c6c948c0c706167655f686973746f7279945d94288c51687474703a2f2f6c6f63616c686f73743a383038302f64616772756e2f6c6973742f3f5f666c745f335f6461675f69643d6368696c645f373031333032265f666c745f335f73746174653d6661696c6564948c51687474703a2f2f6c6f63616c686f73743a383038302f64616772756e2f6c6973742f3f5f666c745f335f6461675f69643d6368696c645f363630393731265f666c745f335f73746174653d6661696c6564948c4c687474703a2f2f6c6f63616c686f73743a383038302f64616772756e2f6c6973742f3f5f666c745f335f6461675f69643d706172656e74265f666c745f335f73746174653d737563636573739465752e','2024-11-21 01:46:20.766388');
INSERT INTO session VALUES(3,'e6497093-8e1d-4636-a780-ea10d615e4b9',X'80049563000000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894898c0a637372665f746f6b656e948c2839653634306261663139633836653564366666323263663636376362333630633737313534653563948c066c6f63616c65948c02656e94752e','2024-11-21 01:50:35.253641');
INSERT INTO session VALUES(4,'f6f0f607-4916-4139-9e3a-ff20424d159d',X'80049563000000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894898c0a637372665f746f6b656e948c2834363330393030303034353665626131663338643932323866353331333038306436633066343639948c066c6f63616c65948c02656e94752e','2024-11-21 10:48:20.889729');
INSERT INTO session VALUES(5,'83b580ae-ea61-407f-ad3c-f2912cbba359',X'80049574010000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894888c0a637372665f746f6b656e948c2834363330393030303034353665626131663338643932323866353331333038306436633066343639948c066c6f63616c65948c02656e948c085f757365725f6964944b028c035f6964948c803338653566323766613463623333303964326463626336376537313463363466343334386665323431373730646139376130303761646133353235376233336238643064636334313131663335353039323533336565353161383364643339653637366336303536383265333234393263666533626438646465353434653665948c116461675f7374617475735f66696c746572948c03616c6c948c0c706167655f686973746f7279945d948c4c687474703a2f2f6c6f63616c686f73743a383038302f64616772756e2f6c6973742f3f5f666c745f335f6461675f69643d706172656e74265f666c745f335f73746174653d737563636573739461752e','2024-11-21 10:56:15.331743');
INSERT INTO session VALUES(6,'f64f3e3b-5498-481b-927c-128a5dba843b',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 10:56:15.775166');
INSERT INTO session VALUES(7,'ae5586d5-f99d-4b24-8f5c-ef3b3acd030c',X'80049563000000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894898c0a637372665f746f6b656e948c2838346235386334313232383832366632613039383763393865636266336530633739353862313138948c066c6f63616c65948c02656e94752e','2024-11-21 10:56:23.839666');
INSERT INTO session VALUES(8,'2ebf0d9f-0406-447e-9f73-84f07ee0da39',X'80049516010000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894888c0a637372665f746f6b656e948c2838346235386334313232383832366632613039383763393865636266336530633739353862313138948c066c6f63616c65948c02656e948c085f757365725f6964944b028c035f6964948c803338653566323766613463623333303964326463626336376537313463363466343334386665323431373730646139376130303761646133353235376233336238643064636334313131663335353039323533336565353161383364643339653637366336303536383265333234393263666533626438646465353434653665948c116461675f7374617475735f66696c746572948c0661637469766594752e','2024-11-21 18:05:09.275630');
INSERT INTO session VALUES(9,'8a5c8260-3318-45c5-9909-19d7b8d98e72',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 17:15:52.486657');
INSERT INTO session VALUES(10,'737de954-36aa-483f-87bb-e17f43f5b849',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 17:15:52.491208');
INSERT INTO session VALUES(11,'27690b97-387e-4202-8401-a2fbb4f22136',X'80049549000000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894898c085f666c6173686573945d948c0664616e676572948c104163636573732069732044656e69656494869461752e','2024-11-21 17:35:30.366673');
INSERT INTO session VALUES(12,'b90eaea5-7592-4970-9665-0592567e5f91',X'80049563000000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894898c0a637372665f746f6b656e948c2866326161383530323165656563643830616661623534313335633937656135633038333436343631948c066c6f63616c65948c02656e94752e','2024-11-21 17:35:30.632385');
INSERT INTO session VALUES(13,'d98b4d52-a4a5-43eb-bf14-d9f706748e2f',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 17:35:31.913424');
INSERT INTO session VALUES(14,'1519acda-0c32-4569-b158-5a08f6129d67',X'80049549000000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894898c085f666c6173686573945d948c0664616e676572948c104163636573732069732044656e69656494869461752e','2024-11-21 17:35:31.299643');
INSERT INTO session VALUES(15,'c8fdde85-cf92-4d0a-be8f-fad5e2f78c68',X'80049563000000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894898c0a637372665f746f6b656e948c2834346661626363373535633037306362386361333432376338656636333134383864316638653636948c066c6f63616c65948c02656e94752e','2024-11-21 17:35:31.379314');
INSERT INTO session VALUES(16,'7323630b-ed7d-4121-a893-fee8d8bbce65',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:09.520869');
INSERT INTO session VALUES(17,'84e022f8-7e14-4dda-972b-dfd3f9f40638',X'80049563000000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894898c0a637372665f746f6b656e948c2838366335656364623965626265646661386366646335636665353261653033323664386162393466948c066c6f63616c65948c02656e94752e','2024-11-21 18:05:35.612709');
INSERT INTO session VALUES(18,'80fa1d8e-f148-482a-a1a1-f7de4282a3d5',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:08.864015');
INSERT INTO session VALUES(19,'e3ffa432-c3ef-4d37-8105-424a7e402997',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:08.881704');
INSERT INTO session VALUES(20,'66776d79-7773-43dd-8997-39799e3a85b4',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:08.894662');
INSERT INTO session VALUES(21,'541d0da3-e054-4ebf-b787-4c508e5361f0',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:08.902826');
INSERT INTO session VALUES(22,'70ecb7e6-6556-460a-b8d9-a77d769c891c',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:08.911220');
INSERT INTO session VALUES(23,'8883a8a4-26e5-4d8d-8f27-c95b1d08242f',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:08.922773');
INSERT INTO session VALUES(24,'9b406f86-fdd4-4c1d-a953-ad574d73f770',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:08.930713');
INSERT INTO session VALUES(25,'3ab8073e-df85-4d7b-b3fa-6f88cd92203d',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:08.947388');
INSERT INTO session VALUES(26,'258a4dc7-004f-4369-a19e-ec1b0ce31915',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:08.948388');
INSERT INTO session VALUES(27,'8c97a515-3d44-4890-a280-4428aa9bf119',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:08.968775');
INSERT INTO session VALUES(28,'2926bd5d-a8c8-460f-9d99-6ecaf7e731b8',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:08.969944');
INSERT INTO session VALUES(29,'fc21bcb0-276c-4e3e-8ab8-7e5d85613ee1',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:08.987358');
INSERT INTO session VALUES(30,'8bce3b6f-d0a6-427f-8244-6ef4f0373689',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:08.991903');
INSERT INTO session VALUES(31,'6377e2f5-3587-435c-853e-6a6a169ccf13',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:09.012074');
INSERT INTO session VALUES(32,'5b379912-087c-452e-8dd7-557195f08298',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:09.019559');
INSERT INTO session VALUES(33,'76dd575c-bdca-427d-a470-75d2471e0935',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:09.038566');
INSERT INTO session VALUES(34,'08a38c0b-8791-4daf-b6b8-56a3f94fb510',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:09.042068');
INSERT INTO session VALUES(35,'1da95b5e-5df1-43b1-a7fd-8cfdf87a553d',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:09.065381');
INSERT INTO session VALUES(36,'a68fedd7-57db-4032-bcdc-294a06909dce',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:09.081242');
INSERT INTO session VALUES(37,'a3734187-828d-47de-99ec-31fade97b2ec',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:09.092019');
INSERT INTO session VALUES(38,'01a7277f-8847-43cb-8fa8-b5998504ab0f',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:09.107795');
INSERT INTO session VALUES(39,'b198679d-57e4-4088-adae-8bc8d7897142',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:09.108100');
INSERT INTO session VALUES(40,'b2748c85-0bd5-423e-8ffd-a34ef3a27ac1',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:09.123910');
INSERT INTO session VALUES(41,'a7f0b1fa-18c3-4a29-b950-ea98be75ef59',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:09.141651');
INSERT INTO session VALUES(42,'0fc5030f-51f7-4cf2-8221-33f507fe2b15',X'80049513010000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894888c0a637372665f746f6b656e948c2838366335656364623965626265646661386366646335636665353261653033323664386162393466948c066c6f63616c65948c02656e948c085f757365725f6964944b028c035f6964948c803338653566323766613463623333303964326463626336376537313463363466343334386665323431373730646139376130303761646133353235376233336238643064636334313131663335353039323533336565353161383364643339653637366336303536383265333234393263666533626438646465353434653665948c116461675f7374617475735f66696c746572948c03616c6c94752e','2024-11-21 18:05:52.747240');
INSERT INTO session VALUES(43,'f6e874b9-41cf-4999-b327-bd545bb1cdb0',X'80049563000000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894898c0a637372665f746f6b656e948c2863613733303830396437336564306566623333383033623933393731313031303635333138393731948c066c6f63616c65948c02656e94752e','2024-11-21 18:06:02.576749');
INSERT INTO session VALUES(44,'d8715a92-0b6d-4bb2-82c4-78d19e3a3cfe',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:52.126956');
INSERT INTO session VALUES(45,'47af4cd6-2f38-4a3a-babc-a12eeb6d54b7',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:52.132192');
INSERT INTO session VALUES(46,'6a7659af-a3e3-4aa3-a7bd-22fc049b4373',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:52.144387');
INSERT INTO session VALUES(47,'0c312548-d046-4732-95f2-4e368d6dee67',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:52.152712');
INSERT INTO session VALUES(48,'6b4d9245-3365-4e7d-82ca-7e6bc7f4d001',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:52.166931');
INSERT INTO session VALUES(49,'137d21e5-4ff4-4b30-9b59-6ac33a019a11',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:52.174929');
INSERT INTO session VALUES(50,'4614b7d1-0973-4607-b3f1-5712194363ab',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:52.183459');
INSERT INTO session VALUES(51,'5b8a2a16-1fae-49e9-9692-885994c35509',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:52.190600');
INSERT INTO session VALUES(52,'40fbd929-a48b-491f-85b5-0097f7cfca75',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:52.200229');
INSERT INTO session VALUES(53,'97c3d348-0ebb-4135-9fa9-37d9842be99e',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:52.210029');
INSERT INTO session VALUES(54,'3ee2c63b-a219-49ef-9644-ea87b9fec44c',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:52.224120');
INSERT INTO session VALUES(55,'e5e0b3ee-d27c-4fcc-9e90-ef0c76b288d4',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:52.231354');
INSERT INTO session VALUES(56,'41f61a0d-57d3-4d20-b999-5d998f4eb86f',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:52.244740');
INSERT INTO session VALUES(57,'c3ae2e61-67c9-48e2-934f-b33ca22deca4',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:52.252879');
INSERT INTO session VALUES(58,'052fab71-db26-4ddd-880f-6ca6a749ccd6',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:52.260832');
INSERT INTO session VALUES(59,'0decca89-42b5-4763-ab57-127eb7a7c7c0',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:52.273916');
INSERT INTO session VALUES(60,'d27a8e7b-373f-4d56-8cdc-84098022f86e',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:52.280913');
INSERT INTO session VALUES(61,'ab3f7186-6f64-49e6-a6b9-74b4cf312b7c',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:52.292386');
INSERT INTO session VALUES(62,'b981aaff-deca-4c6a-b4d2-b4d88263c81d',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:52.300570');
INSERT INTO session VALUES(63,'7d84a594-f2f4-450f-9e53-a3fe1ae257fc',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:52.322929');
INSERT INTO session VALUES(64,'e5bf5599-36af-445f-9d51-59f9fc2c2e10',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:52.323926');
INSERT INTO session VALUES(65,'b8e757d5-579c-478c-b5f5-4326cb69d58c',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:52.340998');
INSERT INTO session VALUES(66,'ecdd99ff-34a9-4a24-bf80-51a1adb45e40',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:52.349184');
INSERT INTO session VALUES(67,'446bad40-f9a0-408c-8a56-6b0f5b82a660',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:52.364262');
INSERT INTO session VALUES(68,'2b55556c-e4ac-49c3-82f8-32e1119d08e7',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:05:52.365965');
INSERT INTO session VALUES(69,'1d3a67bd-2172-4750-b3db-7b134da48e60',X'80049513010000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894888c0a637372665f746f6b656e948c2863613733303830396437336564306566623333383033623933393731313031303635333138393731948c066c6f63616c65948c02656e948c085f757365725f6964944b028c035f6964948c803338653566323766613463623333303964326463626336376537313463363466343334386665323431373730646139376130303761646133353235376233336238643064636334313131663335353039323533336565353161383364643339653637366336303536383265333234393263666533626438646465353434653665948c116461675f7374617475735f66696c746572948c03616c6c94752e','2024-11-21 18:24:47.889788');
INSERT INTO session VALUES(70,'8cf04308-249f-4162-945f-b5e0e0a29972',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:08:47.499081');
INSERT INTO session VALUES(71,'2bc71656-abf9-4f07-9ef3-91e1f7b4ec30',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:08:47.611417');
INSERT INTO session VALUES(72,'5102030e-e637-4d74-90ba-2f58345ff396',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:08:47.625543');
INSERT INTO session VALUES(73,'7220843e-7943-4742-9c92-6a8326314997',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:24:48.036046');
INSERT INTO session VALUES(74,'bf7ab5ab-58ce-4e32-9984-625a55dd77bb',X'80049563000000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894898c0a637372665f746f6b656e948c2832316265666434396464346265363336313863306465376165666438323862343830383034326238948c066c6f63616c65948c02656e94752e','2024-11-21 18:24:53.973980');
INSERT INTO session VALUES(75,'784f7ed4-f61e-454e-8e87-178a13aaf88f',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:24:47.654571');
INSERT INTO session VALUES(76,'4f79d7fb-54d4-4ea9-b0ca-37278a538614',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:24:47.655056');
INSERT INTO session VALUES(77,'e7dabcb4-7a2c-427c-862d-01639e1c3576',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:24:47.674897');
INSERT INTO session VALUES(78,'75c698a2-bb98-4be5-9141-149fb6e5d3bf',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:24:47.675716');
INSERT INTO session VALUES(79,'d343ce8a-e31b-4759-adac-718c9921a757',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:24:47.693960');
INSERT INTO session VALUES(80,'85a78d16-bdbc-42d9-a585-f82659ef4863',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:24:47.695417');
INSERT INTO session VALUES(81,'8e7bfd32-6081-4b5b-a605-68201bd743e2',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:24:47.716616');
INSERT INTO session VALUES(82,'f92d8280-71d5-4b41-8f48-01d20df0980d',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:24:47.719433');
INSERT INTO session VALUES(83,'f72aa9a3-1b99-412c-891c-fd65f87e0800',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:24:47.734844');
INSERT INTO session VALUES(84,'2bcc4413-508a-4213-883f-097b76bff4ca',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:24:47.740238');
INSERT INTO session VALUES(85,'90aded3e-32d1-4ef3-acce-9d98929138f4',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:24:47.748696');
INSERT INTO session VALUES(86,'4be6241d-09ca-4c8f-b11e-30e271597928',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:24:47.755208');
INSERT INTO session VALUES(87,'32010c2c-49a7-4e06-9fd6-7fda5d3a531e',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:24:47.762713');
INSERT INTO session VALUES(88,'bc6d09c4-7110-4da1-96fe-e1d9ed0f906f',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:24:47.769466');
INSERT INTO session VALUES(89,'4200138c-151a-48aa-b2b7-2cfc80599279',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:24:47.776421');
INSERT INTO session VALUES(90,'9e9e6476-596e-4820-b0e8-20ec5a6c8981',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:24:47.784462');
INSERT INTO session VALUES(91,'8969c452-31f7-4a55-808b-6fc40d09b17c',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:24:47.792652');
INSERT INTO session VALUES(92,'321b3103-0c30-4d27-977b-2c0b2d2378ec',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:24:47.803771');
INSERT INTO session VALUES(93,'d1ec8391-ca3b-47b7-b34c-047235cf8faf',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:24:47.814248');
INSERT INTO session VALUES(94,'ecdfefa9-d1d9-4dae-9e79-1d1725783f29',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:24:47.822717');
INSERT INTO session VALUES(95,'2aaf1c25-137c-413c-9e4c-f00e75d944c9',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:24:47.834308');
INSERT INTO session VALUES(96,'9cbf74e9-200b-49c6-8831-b41d551e4da2',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:24:47.835452');
INSERT INTO session VALUES(97,'837a5d2f-1f4a-4dd5-8d7f-c91a2731eaa8',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:24:47.849230');
INSERT INTO session VALUES(98,'e357bbeb-368a-4c94-9094-e995ed9750bd',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:24:47.855769');
INSERT INTO session VALUES(99,'d4b01d28-582b-446a-b344-be8c7b82498e',X'8004954e010000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894888c0a637372665f746f6b656e948c2832316265666434396464346265363336313863306465376165666438323862343830383034326238948c066c6f63616c65948c02656e948c085f757365725f6964944b028c035f6964948c803338653566323766613463623333303964326463626336376537313463363466343334386665323431373730646139376130303761646133353235376233336238643064636334313131663335353039323533336565353161383364643339653637366336303536383265333234393263666533626438646465353434653665948c0c706167655f686973746f7279945d948c26687474703a2f2f6c6f63616c686f73743a383038302f636f6e6e656374696f6e2f6c6973742f94618c116461675f7374617475735f66696c746572948c03616c6c94752e','2024-11-21 18:26:34.613000');
INSERT INTO session VALUES(100,'9ac5474c-09bf-4920-9abb-22b5617a9b5e',X'80049563000000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894898c0a637372665f746f6b656e948c2836326136393235393338646533663439383633366533343430316166626463363234616532623366948c066c6f63616c65948c02656e94752e','2024-11-21 18:27:32.026424');
INSERT INTO session VALUES(101,'ef15a2c1-10b1-4c6c-a750-8b5b45a52dd7',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:26:34.294395');
INSERT INTO session VALUES(102,'8c33f68b-87bb-401b-8c01-0b6d7cc1cb05',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:26:34.333750');
INSERT INTO session VALUES(103,'edde3241-bfed-46d6-bf3a-6d008da5b767',X'80049572010000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894888c0a637372665f746f6b656e948c2836326136393235393338646533663439383633366533343430316166626463363234616532623366948c066c6f63616c65948c02656e948c085f757365725f6964944b028c035f6964948c803338653566323766613463623333303964326463626336376537313463363466343334386665323431373730646139376130303761646133353235376233336238643064636334313131663335353039323533336565353161383364643339653637366336303536383265333234393263666533626438646465353434653665948c116461675f7374617475735f66696c746572948c03616c6c948c0c706167655f686973746f7279945d948c4a687474703a2f2f6c6f63616c686f73743a383038302f64616772756e2f6c6973742f3f5f666c745f335f6461675f69643d7073675f32265f666c745f335f73746174653d6661696c65649461752e','2024-11-21 18:28:10.687228');
INSERT INTO session VALUES(104,'68a9864f-c122-4a52-a692-79129ae935d5',X'80049563000000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894898c0a637372665f746f6b656e948c2830663365623830333163316437653937326531653963323932363839613532653663666333313339948c066c6f63616c65948c02656e94752e','2024-11-21 18:31:25.849757');
INSERT INTO session VALUES(105,'2ed11be4-6cf0-4ea7-b05e-76c188a7990d',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:28:10.163254');
INSERT INTO session VALUES(106,'ed7cfcfe-f15a-4c89-990b-428186b63180',X'80049513010000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894888c0a637372665f746f6b656e948c2830663365623830333163316437653937326531653963323932363839613532653663666333313339948c066c6f63616c65948c02656e948c085f757365725f6964944b028c035f6964948c803338653566323766613463623333303964326463626336376537313463363466343334386665323431373730646139376130303761646133353235376233336238643064636334313131663335353039323533336565353161383364643339653637366336303536383265333234393263666533626438646465353434653665948c116461675f7374617475735f66696c746572948c03616c6c94752e','2024-11-21 18:32:45.187466');
INSERT INTO session VALUES(107,'47e5ef56-6784-4e09-87d8-48cdde016900',X'80049563000000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894898c0a637372665f746f6b656e948c2831346563303137333465383762353430363033633636353237653639336631323664323332633532948c066c6f63616c65948c02656e94752e','2024-11-21 18:33:11.450652');
INSERT INTO session VALUES(108,'a136eeaa-5ad4-4751-8473-8396a3e3c596',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:32:44.981800');
INSERT INTO session VALUES(109,'5c5e3298-b582-42f7-8fc7-be43e00bb282',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:32:45.024769');
INSERT INTO session VALUES(110,'ec1f17fd-0959-40e2-ae06-b668293314fe',X'80049513010000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894888c0a637372665f746f6b656e948c2831346563303137333465383762353430363033633636353237653639336631323664323332633532948c066c6f63616c65948c02656e948c085f757365725f6964944b028c035f6964948c803338653566323766613463623333303964326463626336376537313463363466343334386665323431373730646139376130303761646133353235376233336238643064636334313131663335353039323533336565353161383364643339653637366336303536383265333234393263666533626438646465353434653665948c116461675f7374617475735f66696c746572948c03616c6c94752e','2024-11-21 18:42:28.264506');
INSERT INTO session VALUES(111,'14bebd64-48aa-4acb-9f03-3c27cbfad77c',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:41:57.408878');
INSERT INTO session VALUES(112,'a334cf86-248f-47d0-8fe3-873fe9f6b9e8',X'80049563000000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894898c0a637372665f746f6b656e948c2866393330366132353765363666323263656139376365646435636633386131356630393365623638948c066c6f63616c65948c02656e94752e','2024-11-21 18:42:40.880414');
INSERT INTO session VALUES(113,'3f10ee75-840b-45d6-af7c-03e38b934f39',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:42:27.933692');
INSERT INTO session VALUES(114,'039b5035-d679-4f79-9b2c-d659b4c7881f',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 18:42:27.951351');
INSERT INTO session VALUES(115,'2d55e450-553a-4d06-ac84-e758657e986a',X'80049513010000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894888c0a637372665f746f6b656e948c2866393330366132353765363666323263656139376365646435636633386131356630393365623638948c066c6f63616c65948c02656e948c085f757365725f6964944b028c035f6964948c803338653566323766613463623333303964326463626336376537313463363466343334386665323431373730646139376130303761646133353235376233336238643064636334313131663335353039323533336565353161383364643339653637366336303536383265333234393263666533626438646465353434653665948c116461675f7374617475735f66696c746572948c03616c6c94752e','2024-11-21 20:02:17.910085');
INSERT INTO session VALUES(116,'3320b235-1c21-4c58-ad5f-766ce571d169',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:01:59.840494');
INSERT INTO session VALUES(117,'2707101c-6fbf-4c4b-b293-bcf6716b86b3',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:01:58.647195');
INSERT INTO session VALUES(118,'565ba4f7-fa4d-4c9b-9238-282d182d29ea',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:01:58.700264');
INSERT INTO session VALUES(119,'48b5b33b-0220-425c-9972-5d98f55e25b9',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:02:06.693674');
INSERT INTO session VALUES(120,'ffff2320-2092-433c-8548-36d7cfd34e6f',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:02:06.713476');
INSERT INTO session VALUES(121,'119a0f57-0511-419e-bb23-9711e1884887',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:02:06.722637');
INSERT INTO session VALUES(122,'32886fc6-d48c-4988-9086-682dcc5afbed',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:02:06.737453');
INSERT INTO session VALUES(123,'20b56bc3-c5d7-4403-8679-13080086fb05',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:02:06.757015');
INSERT INTO session VALUES(124,'26fd7d3c-f8aa-47fa-9257-b4083db68a3c',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:02:06.796760');
INSERT INTO session VALUES(125,'bad85e7a-2658-4923-b6a6-76170ba80bde',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:02:06.811767');
INSERT INTO session VALUES(126,'0cf10ae1-5bce-4294-a763-56bb66ce6011',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:02:06.839988');
INSERT INTO session VALUES(127,'4c7d531c-d741-4aac-b61f-3ddcc485b4c0',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:02:06.859733');
INSERT INTO session VALUES(128,'d0a5d8a3-d55d-4184-8802-a91bbdf0b09b',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:02:06.867850');
INSERT INTO session VALUES(129,'d6413b4d-0323-44f4-937c-c335d684d4a9',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:02:06.889962');
INSERT INTO session VALUES(130,'bbbb2657-9607-41c3-a01b-cce2be936c61',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:02:06.892860');
INSERT INTO session VALUES(131,'6b086212-aa54-47af-8258-eac6ab6deef1',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:02:06.917947');
INSERT INTO session VALUES(132,'36f5bf88-f0d4-4a3d-a81f-42aafc645c68',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:02:06.934506');
INSERT INTO session VALUES(133,'28fd6875-8c6f-46f9-bdee-d07dc321500c',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:02:06.944674');
INSERT INTO session VALUES(134,'d3f60b87-3ac6-40a0-a20e-eabea4aa4af3',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:02:06.980516');
INSERT INTO session VALUES(135,'e7cd8986-15dc-42ff-bbb5-327ebdf740e1',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:02:07.004533');
INSERT INTO session VALUES(136,'f1aa0c9a-7635-453d-bf8a-6379c018428a',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:02:07.016086');
INSERT INTO session VALUES(137,'b7df4bb0-59f1-4bf1-a8d9-ab9e16538ff5',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:02:07.030200');
INSERT INTO session VALUES(138,'54ecde9c-edea-4c1d-b2f2-1bea7c731d8d',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:02:07.040303');
INSERT INTO session VALUES(139,'ba1261d3-33d7-4abc-b3b0-b364009a9af9',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:02:07.059961');
INSERT INTO session VALUES(140,'701fb927-92e4-453c-85e8-7eff8d7d568f',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:02:07.070268');
INSERT INTO session VALUES(141,'db0b77a1-649f-4811-b0b5-d95938e91b7d',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:02:07.090226');
INSERT INTO session VALUES(142,'29f4562f-bbdc-4767-91db-53f02c701fa0',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:02:07.143699');
INSERT INTO session VALUES(143,'d24872f8-e801-477d-a5aa-11e93fc52bc3',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:02:07.144948');
INSERT INTO session VALUES(144,'811b1ef0-126a-4c81-80cc-461f5db75038',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:02:07.185909');
INSERT INTO session VALUES(145,'e7fe649f-7c8f-4f11-9061-402b84112b6e',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:02:18.385470');
INSERT INTO session VALUES(146,'6897ee49-0e34-4938-a153-e872453cda36',X'80049563000000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894898c0a637372665f746f6b656e948c2861656439653836626364326362643565363837343532393865336162613332303962383865333239948c066c6f63616c65948c02656e94752e','2024-11-21 20:02:32.330621');
INSERT INTO session VALUES(147,'8ec886e5-2dd7-40ba-9be7-40536e017527',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:02:18.010297');
INSERT INTO session VALUES(148,'5276f44e-01bc-47ea-bc8a-900d2174a462',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:02:18.030258');
INSERT INTO session VALUES(149,'b2ec7ca9-eea7-437f-846c-04ae81f6620a',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:02:18.047267');
INSERT INTO session VALUES(150,'25f167b9-e40b-4e50-ba78-5d0489297d9d',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:02:18.065948');
INSERT INTO session VALUES(151,'e6c2d8e5-747d-42fa-bc44-c19a450eba45',X'80049513010000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894888c0a637372665f746f6b656e948c2861656439653836626364326362643565363837343532393865336162613332303962383865333239948c066c6f63616c65948c02656e948c085f757365725f6964944b028c035f6964948c803338653566323766613463623333303964326463626336376537313463363466343334386665323431373730646139376130303761646133353235376233336238643064636334313131663335353039323533336565353161383364643339653637366336303536383265333234393263666533626438646465353434653665948c116461675f7374617475735f66696c746572948c03616c6c94752e','2024-11-21 20:07:48.918475');
INSERT INTO session VALUES(152,'f7ee28fb-b5e6-449e-afb1-ac291a0cf402',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:03:24.096128');
INSERT INTO session VALUES(153,'812c6855-1d5c-496c-9788-f4a28b47bc29',X'80049563000000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894898c0a637372665f746f6b656e948c2838376332613539303963613034343438366232363861633164613938376561646264393263393137948c066c6f63616c65948c02656e94752e','2024-11-21 20:08:10.176474');
INSERT INTO session VALUES(154,'c4625d89-34f5-4db4-b249-8316a9d09610',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:07:48.937973');
INSERT INTO session VALUES(155,'f06a54a0-43bb-43da-ab6d-cb111ee75fa6',X'80049513010000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894888c0a637372665f746f6b656e948c2838376332613539303963613034343438366232363861633164613938376561646264393263393137948c066c6f63616c65948c02656e948c085f757365725f6964944b028c035f6964948c803338653566323766613463623333303964326463626336376537313463363466343334386665323431373730646139376130303761646133353235376233336238643064636334313131663335353039323533336565353161383364643339653637366336303536383265333234393263666533626438646465353434653665948c116461675f7374617475735f66696c746572948c03616c6c94752e','2024-11-21 20:26:15.191813');
INSERT INTO session VALUES(156,'9d50a68a-8095-41d2-9ef6-8018e1f1d18b',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:14:17.929859');
INSERT INTO session VALUES(157,'64cec2a7-6039-43d1-9d48-edb6939ffddc',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:14:17.242063');
INSERT INTO session VALUES(158,'03e765af-efa2-4c56-8b1a-79f4eab69930',X'80049563000000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894898c0a637372665f746f6b656e948c2864653232316435363830333563343263646662353536616638663362353263306439326438393535948c066c6f63616c65948c02656e94752e','2024-11-21 20:26:24.164213');
INSERT INTO session VALUES(159,'68c7c52d-3a56-473a-92d3-4dca4a2b50d1',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 20:26:14.644302');
INSERT INTO session VALUES(160,'92428015-83d6-4fb6-9b3e-7bca7bf9d25f',X'80049513010000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894888c0a637372665f746f6b656e948c2864653232316435363830333563343263646662353536616638663362353263306439326438393535948c066c6f63616c65948c02656e948c085f757365725f6964944b028c035f6964948c803338653566323766613463623333303964326463626336376537313463363466343334386665323431373730646139376130303761646133353235376233336238643064636334313131663335353039323533336565353161383364643339653637366336303536383265333234393263666533626438646465353434653665948c116461675f7374617475735f66696c746572948c03616c6c94752e','2024-11-21 21:21:57.774136');
INSERT INTO session VALUES(161,'3d85a04a-6e71-45f0-b46e-f2fe35d61bac',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 21:00:27.448958');
INSERT INTO session VALUES(162,'34520e9b-df55-4c7e-bb40-88d52cd0d89a',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 21:00:26.412119');
INSERT INTO session VALUES(163,'242f35d8-9406-4d9c-8385-c545b5fe82b4',X'80049563000000000000007d94288c0a5f7065726d616e656e7494888c065f667265736894898c0a637372665f746f6b656e948c2830373066303931346232313862356366303238356436323138623730376139633235353335393531948c066c6f63616c65948c02656e94752e','2024-11-21 21:22:03.567995');
INSERT INTO session VALUES(164,'10418e62-6923-41d0-88dc-f73af3eecfe0',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 21:21:57.207236');
INSERT INTO session VALUES(165,'ce29009a-35ee-4772-9b2b-c7a29d1e3ebf',X'8004957d000000000000007d94288c0a5f7065726d616e656e7494888c0a637372665f746f6b656e948c2830373066303931346232313862356366303238356436323138623730376139633235353335393531948c066c6f63616c65948c02656e948c116461675f7374617475735f66696c746572948c03616c6c948c065f66726573689489752e','2024-11-21 22:55:00.112326');
INSERT INTO session VALUES(166,'8c3ae66e-e577-4644-bd4f-27a8eb289e08',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 22:49:11.747895');
INSERT INTO session VALUES(167,'dd3eed2b-1c80-40b8-9856-4215918af407',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 22:49:11.824074');
INSERT INTO session VALUES(168,'64d3b30c-21f1-41ac-af8c-649ed75adf3e',X'80049513010000000000007d94288c0a5f7065726d616e656e7494888c0a637372665f746f6b656e948c2830373066303931346232313862356366303238356436323138623730376139633235353335393531948c066c6f63616c65948c02656e948c116461675f7374617475735f66696c746572948c03616c6c948c065f667265736894888c085f757365725f6964944b028c035f6964948c80333865356632376661346362333330396432646362633637653731346336346634333438666532343137373064613937613030376164613335323537623333623864306463633431313166333535303932353333656535316138336464333965363736633630353638326533323439326366653362643864646535343465366594752e','2024-11-21 23:29:06.984215');
INSERT INTO session VALUES(169,'16c998e4-1d27-4260-a6f4-56d7f54be583',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 22:55:28.676857');
INSERT INTO session VALUES(170,'7c9449af-e606-4d02-bd6c-a0823884ce0f',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 22:55:28.702494');
INSERT INTO session VALUES(171,'4113b79f-4408-45f9-81c7-fa08d5e96c8d',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 23:24:22.059672');
INSERT INTO session VALUES(172,'a5cf5801-27f8-4439-a117-f9fa153387ca',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 23:24:22.159888');
INSERT INTO session VALUES(173,'6f5c7115-49e6-488e-b93c-ddee67491b13',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 23:24:22.162564');
INSERT INTO session VALUES(174,'65ad0815-b01e-42f7-90dc-e1570c63f0bb',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 23:24:22.190852');
INSERT INTO session VALUES(175,'2c6c2786-7f05-4bfe-887b-d135dfa60f9c',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 23:24:22.193569');
INSERT INTO session VALUES(176,'34e4a49a-a739-4f54-8b95-4725a10e743c',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 23:24:22.209123');
INSERT INTO session VALUES(177,'5bff5d26-3b8d-4f3e-bb7e-0ce4650cd067',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 23:24:22.215926');
INSERT INTO session VALUES(178,'12e5c771-663a-4eb4-a083-aa4f186fdb32',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 23:24:22.232075');
INSERT INTO session VALUES(179,'c031bb58-1e3f-4700-ad32-1d1ea4189b8e',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 23:24:22.232564');
INSERT INTO session VALUES(180,'eeb59e43-4e10-4a9d-8872-d8ad4a5b7288',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 23:24:22.249351');
INSERT INTO session VALUES(181,'0c881619-4d10-45e5-912b-a62579bbc8c0',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 23:24:22.251400');
INSERT INTO session VALUES(182,'c8ec1929-cfd8-4244-a4e7-34aaf723a537',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 23:24:22.265027');
INSERT INTO session VALUES(183,'61b03476-845d-42d8-911a-fea80177ce38',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 23:24:22.274908');
INSERT INTO session VALUES(184,'737a7a87-de1b-4113-a2d1-31e54fd30ce2',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 23:24:22.287692');
INSERT INTO session VALUES(185,'e2a3a64a-58ee-4854-ba33-ed1fac810a85',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 23:24:22.295702');
INSERT INTO session VALUES(186,'d04fea47-92b5-422b-9a20-464afd36e6f2',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 23:24:22.307077');
INSERT INTO session VALUES(187,'d92e4dd0-a747-4cab-b43f-74bb15ca65df',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 23:24:22.312503');
INSERT INTO session VALUES(188,'ac5ce7f2-8c2f-44bd-8f84-4937012162d5',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 23:24:22.323514');
INSERT INTO session VALUES(189,'24230207-3b28-409b-9543-9c22243e5acb',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 23:24:22.328690');
INSERT INTO session VALUES(190,'1c16e9a2-675f-4279-9085-d5e353883bea',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 23:24:22.340501');
INSERT INTO session VALUES(191,'5a4f6390-2539-40c6-b323-d51f73173b4a',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 23:24:22.343464');
INSERT INTO session VALUES(192,'20029cdb-983c-4c18-9700-172880f2ec21',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 23:24:22.354892');
INSERT INTO session VALUES(193,'6fa5be1d-c598-496d-9d07-556d9b940f3a',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 23:24:22.356293');
INSERT INTO session VALUES(194,'632260a6-7f6b-4c65-b758-c63e33daf790',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 23:24:22.378404');
INSERT INTO session VALUES(195,'a80624a7-75a1-4443-97a3-6fd3bbda5fd3',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 23:24:22.379977');
INSERT INTO session VALUES(196,'f748b3ee-4739-44c4-8687-ed9a4430ecc4',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 23:24:22.391367');
INSERT INTO session VALUES(197,'223514a6-0888-4537-a72c-2d87071c5081',X'8004951d000000000000007d94288c0a5f7065726d616e656e7494888c065f66726573689489752e','2024-11-21 23:24:22.393371');
CREATE TABLE alembic_version (
	version_num VARCHAR(32) NOT NULL, 
	CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num)
);
INSERT INTO alembic_version VALUES('e07f49787c9d');
DELETE FROM sqlite_sequence;
CREATE INDEX idx_log_event ON log (event);
CREATE INDEX idx_log_dag ON log (dag_id);
CREATE UNIQUE INDEX idx_uri_unique ON dataset (uri);
CREATE INDEX idx_dataset_id_timestamp ON dataset_event (dataset_id, timestamp);
CREATE INDEX idx_root_dag_id ON dag (root_dag_id);
CREATE INDEX idx_next_dagrun_create_after ON dag (next_dagrun_create_after);
CREATE INDEX sm_dag ON sla_miss (dag_id);
CREATE INDEX idx_job_state_heartbeat ON job (state, latest_heartbeat);
CREATE INDEX job_type_heart ON job (job_type, latest_heartbeat);
CREATE INDEX idx_job_dag_id ON job (dag_id);
CREATE INDEX idx_fileloc_hash ON serialized_dag (fileloc_hash);
CREATE INDEX idx_dag_run_dag_id ON dag_run (dag_id);
CREATE INDEX idx_last_scheduling_decision ON dag_run (last_scheduling_decision);
CREATE INDEX idx_dag_run_queued_dags ON dag_run (state, dag_id) WHERE state='queued';
CREATE INDEX dag_id_state ON dag_run (dag_id, state);
CREATE INDEX idx_dag_run_running_dags ON dag_run (state, dag_id) WHERE state='running';
CREATE INDEX idx_dagrun_dataset_events_event_id ON dagrun_dataset_event (event_id);
CREATE INDEX idx_dagrun_dataset_events_dag_run_id ON dagrun_dataset_event (dag_run_id);
CREATE INDEX ti_dag_state ON task_instance (dag_id, state);
CREATE INDEX ti_dag_run ON task_instance (dag_id, run_id);
CREATE INDEX ti_job_id ON task_instance (job_id);
CREATE INDEX ti_state ON task_instance (state);
CREATE INDEX ti_pool ON task_instance (pool, state, priority_weight);
CREATE INDEX ti_state_lkp ON task_instance (dag_id, task_id, run_id, state);
CREATE INDEX ti_trigger_id ON task_instance (trigger_id);
CREATE INDEX idx_task_fail_task_instance ON task_fail (dag_id, task_id, run_id, map_index);
CREATE INDEX idx_task_reschedule_dag_run ON task_reschedule (dag_id, run_id);
CREATE INDEX idx_task_reschedule_dag_task_run ON task_reschedule (dag_id, task_id, run_id, map_index);
CREATE INDEX idx_xcom_task_instance ON xcom (dag_id, task_id, run_id, map_index);
CREATE INDEX idx_xcom_key ON xcom ("key");
COMMIT;
