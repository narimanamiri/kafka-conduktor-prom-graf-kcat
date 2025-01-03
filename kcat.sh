#!/bin/bash  

# Configuration  
KAFKA_BROKERS="10.81.15.25:9092"    # Change this to your Kafka broker address  
TOPIC_NAME="test_topic"           # Topic to produce/consume messages  
NUM_MESSAGES=500000                     # Number of messages to produce  

# Produce messages  
function produce_messages {  
    echo "Producing $NUM_MESSAGES messages to topic '$TOPIC_NAME'..."  
    for i in $(seq 1 $NUM_MESSAGES); do  
        echo "Message $i" | kafkacat -P -b 10.81.15.25:9092 -t $TOPIC_NAME  
    done  
    echo "Finished producing messages."  
}  

# Consume messages  
function consume_messages {  
    echo "Consuming messages from topic '$TOPIC_NAME'..."  
    kafkacat -C -b 10.81.15.25:9092 -t $TOPIC_NAME -o beginning -e  
}  

# Run producer and consumer  
produce_messages  
consume_messages
