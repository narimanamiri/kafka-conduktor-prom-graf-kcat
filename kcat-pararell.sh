#!/bin/bash  

# Configuration  
KAFKA_BROKERS="10.81.15.25:9092"    # Change this to your Kafka broker address  
TOPIC_NAME="test_topic"              # Topic to produce/consume messages  
NUM_MESSAGES=9999999999                 # Number of messages to produce  

# Produce messages  
function produce_messages {  
    echo "Producing $NUM_MESSAGES messages to topic '$TOPIC_NAME'..."  
    for i in $(seq 1 $NUM_MESSAGES); do  
        echo "Message $i" | kafkacat -P -b $KAFKA_BROKERS -t $TOPIC_NAME
        echo "Message $i" | kafkacat -P -b 10.81.15.25:9093 -t $TOPIC_NAME  
        echo "Message $i" | kafkacat -P -b 10.81.15.25:9094 -t $TOPIC_NAME
    done  
    echo "Finished producing messages."  
}  

# Consume messages  
function consume_messages {  
    echo "Consuming messages from topic '$TOPIC_NAME'..."  
    kafkacat -C -b $KAFKA_BROKERS -t $TOPIC_NAME -o beginning -e  
    kafkacat -C -b 10.81.15.25:9093 -t $TOPIC_NAME -o beginning -e
    kafkacat -C -b 10.81.15.25:9094 -t $TOPIC_NAME -o beginning -e
}  

# Run producer and consumer in the background  
produce_messages &  # Start producing in the background  
consume_messages    # Start consuming in the foreground  

# Wait for all background jobs to finish  
wait
