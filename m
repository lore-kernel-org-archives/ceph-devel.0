From: =?UTF-8?B?6JSh5qyK5pix?= <chuanyu@cs.nctu.edu.tw>
Subject: cephfs: one cause of mount error 5 = Input/output error
Date: Thu, 2 Aug 2012 22:54:23 +0800
Message-ID: <CAKG+gh-kgwFADFkXQZ+6vrMg+MUwSTDVxeM9hKTUbunov50H_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38708 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281Ab2HBOyZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Aug 2012 10:54:25 -0400
Received: by eeil10 with SMTP id l10so2416185eei.19
        for <ceph-devel@vger.kernel.org>; Thu, 02 Aug 2012 07:54:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I've found that a cause of Input/output error when I mount the cephfs,
however, I'm not sure which part should be improved ( perhaps me ),
but this error would occur when your client has more than 1 network address.

Environment setting:
Ceph mon
  listen on 192.168.10.1:6789

Ceph client
  use private ip: 192.168.100.11
  public ip: 140.113.98.244

---------------------------------------------------

<< ceph client node >>
# ip r
192.168.10.0/24 dev eth0 scope link

# mount -t ceph 192.168.10.1:/ /mnt/ceph -o name=admin,secret=<adminscret>
mount error 5 = Input/output error

# netstat -ntu
tcp        0      0 140.113.98.244:57667    192.168.10.1:6789       ESTABLISHED

<< ceph mon node >>
# tail mon.log
Aug  2 21:53:57 ceph1 ceph-mon: 2012-08-02 21:53:57.348598
7f19d62cc700  0 mon.0@0(leader) e5 handle_command mon_command(status v
0) v1
Aug  2 21:54:59 ceph1 ceph-mon: 2012-08-02 21:54:59.277523
7f19d31a9700  0 -- 192.168.10.1:6789/0 >> 140.113.98.244:0/1892356839
pipe(0x299a000 sd=33 pgs=0 cs=0 l=0).accept peer addr is really
140.113.98.244:0/1892356839 (socket is 140.113.98.244:57667/0)

---------------------------------------------------
Another successful tries

<< ceph client node >>
# ip r
192.168.10.0/24 dev eth0 proto kernel  scope link  src 192.168.100.11

# mount -t ceph 192.168.10.1:/ /mnt/ceph -o name=admin,secret=<adminscret>
Ok

# netstat -ntu
tcp        0      0 192.168.100.11:40545    192.168.10.1:6789       ESTABLISHED

<< ceph mon node >>
# tail mon.log
Aug  2 22:00:51 ceph1 ceph-mon: 2012-08-02 22:00:51.456517
7f19d31a9700  0 -- 192.168.10.1:6789/0 >> 192.168.100.11:0/3665654333
pipe(0x2e54780 sd=33 pgs=0 cs=0 l=0).accept peer addr is really
192.168.100.11:0/3665654333 (socket is 192.168.100.11:40545/0)
Aug  2 22:00:52 ceph1 ceph-mon: 2012-08-02 22:00:52.531184
7f19d62cc700  0 log [INF] : pgmap v194887: 3472 pgs: 3472
active+clean; 274 MB data, 18458 MB used, 12616 GB / 12668 GB avail

For your reference,

Thanks.

Chuanyu
