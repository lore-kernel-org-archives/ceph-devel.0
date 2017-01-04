From: Max Yehorov <myehorov@skytap.com>
Subject: Possible bug in krbd (4.4.0)
Date: Tue, 3 Jan 2017 16:13:01 -0800
Message-ID: <CAJDfiske056EADPT4g0fRUx=uh7C-F3ZzUh6A1ummfUZ6vMuTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34909 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753169AbdADAON (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jan 2017 19:14:13 -0500
Received: by mail-wm0-f50.google.com with SMTP id a197so396736734wmd.0
        for <ceph-devel@vger.kernel.org>; Tue, 03 Jan 2017 16:13:32 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I have encountered a weird possible bug. There is an rbd image mapped
and mounted on a client machine. It is not possible to umount it. Both
lsof and fuser show no mention of neither device nor mountpoint. It is
not exported via nfs kernel server, so unlikely it is blocked by
kernel.

There is an odd pattern in syslog, two osds are constantly loose
connections. A wild guess is that umount tries to contact primary osd
and fails?

After I enabled kernel debug I saw the following:

[9586733.605792] libceph:  con_open ffff880748f58030 10.80.16.74:6812
[9586733.623876] libceph:  connect 10.80.16.74:6812
[9586733.625091] libceph:  connect 10.80.16.74:6812 EINPROGRESS sk_state = 2
[9586756.681246] libceph:  con_keepalive ffff881057d082b8
[9586767.713067] libceph:  fault ffff880748f59830 state 5 to peer
10.80.16.78:6812
[9586767.713593] libceph: osd27 10.80.16.78:6812 socket closed (con state OPEN)
[9586767.721145] libceph:  con_close ffff880748f59830 peer 10.80.16.78:6812
[9586767.724440] libceph:  con_open ffff880748f59830 10.80.16.78:6812
[9586767.742487] libceph:  connect 10.80.16.78:6812
[9586767.743696] libceph:  connect 10.80.16.78:6812 EINPROGRESS sk_state = 2
[9587346.956812] libceph:  try_read start on ffff881057d082b8 state 5
[9587466.968125] libceph:  try_write start ffff881057d082b8 state 5
[9587634.021257] libceph:  fault ffff880748f58030 state 5 to peer
10.80.16.74:6812
[9587634.021781] libceph: osd19 10.80.16.74:6812 socket closed (con state OPEN)
[9587634.029336] libceph:  con_close ffff880748f58030 peer 10.80.16.74:6812
[9587634.032628] libceph:  con_open ffff880748f58030 10.80.16.74:6812
[9587634.050677] libceph:  connect 10.80.16.74:6812
[9587634.051888] libceph:  connect 10.80.16.74:6812 EINPROGRESS sk_state = 2
[9587668.124746] libceph:  fault ffff880748f59830 state 5 to peer
10.80.16.78:6812

grep of ceph_sock_state_change
kernel: [9585833.117190] libceph:  ceph_sock_state_change
ffff880748f58030 state = CON_STATE_OPEN(5) sk_state = TCP_CLOSE_WAIT
kernel: [9585833.121912] libceph:  ceph_sock_state_change
ffff880748f58030 state = CON_STATE_OPEN(5) sk_state = TCP_LAST_ACK
kernel: [9585833.122467] libceph:  ceph_sock_state_change
ffff880748f58030 state = CON_STATE_OPEN(5) sk_state = TCP_CLOSE
kernel: [9585833.151589] libceph:  ceph_sock_state_change
ffff880748f58030 state = CON_STATE_CONNECTING(3) sk_state =
TCP_ESTABLISHED
kernel: [9586733.591304] libceph:  ceph_sock_state_change
ffff880748f58030 state = CON_STATE_OPEN(5) sk_state = TCP_CLOSE_WAIT
kernel: [9586733.596020] libceph:  ceph_sock_state_change
ffff880748f58030 state = CON_STATE_OPEN(5) sk_state = TCP_LAST_ACK
kernel: [9586733.596573] libceph:  ceph_sock_state_change
ffff880748f58030 state = CON_STATE_OPEN(5) sk_state = TCP_CLOSE
kernel: [9586733.625709] libceph:  ceph_sock_state_change
ffff880748f58030 state = CON_STATE_CONNECTING(3) sk_state =
TCP_ESTABLISHED
kernel: [9587634.018152] libceph:  ceph_sock_state_change
ffff880748f58030 state = CON_STATE_OPEN(5) sk_state = TCP_CLOSE_WAIT
kernel: [9587634.022853] libceph:  ceph_sock_state_change
ffff880748f58030 state = CON_STATE_OPEN(5) sk_state = TCP_LAST_ACK
kernel: [9587634.023406] libceph:  ceph_sock_state_change
ffff880748f58030 state = CON_STATE_OPEN(5) sk_state = TCP_CLOSE

A couple of observations:
the two OSDs in question have the same port 6812, but different IPs
(10.80.16.74 and 10.80.16.78), what is more interesting that they have
the same ceph_connection struct, note the ffff880748f59830 in the log
snippet above. So it seems that because two "struct sock *sk" share
the same "ceph_connection *con = sk->sk_user_data" they enter an
endless loop of establishing and closing the connection.

Does it sound plausible?
