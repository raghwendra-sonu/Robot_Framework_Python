import socket
import datetime

def connection_close(connection):
    connection.close()
    print("Connection Closed...")
    del connection

def form_data(request_type,card_number,amount,acquirer_id,terminal_id,caid,terminal_name,mcc):
    trace_audit_number=str(datetime.datetime.now().time()).split(".")[1]
    formed_message = "02 " + request_type + "723A449128E0000016" + card_number + "000000" + amount + "0224094215" + trace_audit_number + "094215" + "0224" + "0224" + mcc + "011" + "41" + "D00000000" + "09" + acquirer_id + "35" + card_number + "                   " + \
                     "200224094215" + terminal_id + caid + terminal_name + "                       "
    return formed_message

def read_data(card_number):
    global data_str
    s.settimeout(10)
    try:
        data_str = s.recv(1024).decode("ISO-8859-1")
    except socket.timeout:  # fail after 10 second of no activity
        return "Didn't receive data! [Timeout]"
    finally:
        connection_close(s)
    if not data_str:
        return
    msg = data_str.split(card_number)
    response = msg[2].strip()
    response_code = response[12:14]
    return response_code

def establish_connection(host, port):
    global s
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((host, int(port)))
    s.settimeout(10)
    print("Connection Established With Server...")

def send_data(data_to_send):
    data = data_to_send
    length = len(data)+2
    bytes = bytearray()
    if length < 256:
        bytes.append(0)
        bytes.append(length)
    else:
        bytes.append(length / 256)
        bytes.append(length % 256)
    s.sendall(bytes)
    s.sendall(data.encode('ISO-8859-1'))