From: Andrey Korolyov <andrey@xdel.ru>
Subject: Authorization issues in the 0.54
Date: Wed, 14 Nov 2012 15:20:59 +0300
Message-ID: <CABYiri8E8Swk0798BR-yimm+Bk1TeoHVMrXZxeEwvvgLCuEOyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:65181 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161178Ab2KNMVW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Nov 2012 07:21:22 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so309178oag.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Nov 2012 04:21:20 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,
In the 0.54 cephx is probably broken somehow:

$ ceph auth add client.qemukvm osd 'allow *' mon 'allow *' mds 'allow
*' -i qemukvm.key
2012-11-14 15:51:23.153910 7ff06441f780 -1 read 65 bytes from qemukvm.key
added key for client.qemukvm

$ ceph auth list
...
client.admin
        key: [xxxxxx]
        caps: [mds] allow *
        caps: [mon] allow *
        caps: [osd] allow *
client.qemukvm
        key: [yyyyyy]
        caps: [mds] allow *
        caps: [mon] allow *
        caps: [osd] allow *
...
$ virsh secret-set-value --secret uuid --base64 yyyyyy
set username in the VM` xml...
$ virsh start testvm
kvm: -drive file=rbd:rbd/vm0:id=qemukvm:key=yyyyyy:auth_supported=cephx\;none:mon_host=192.168.10.125\:6789\;192.168.10.127\:6789\;192.168.10.129\:6789,if=none,id=drive-virtio-disk0,format=raw:
could not open disk image
rbd:rbd/vm0:id=qemukvm:key=yyyyyy:auth_supported=cephx\;none:mon_host=192.168.10.125\:6789\;192.168.10.127\:6789\;192.168.10.129\:6789:
Operation not permitted
$ virsh secret-set-value --secret uuid --base64 xxxxxx
set username again to admin for the VM` disk
$ virsh start testvm
Finally, vm started successfully.

All rbd commands issued from cli works okay with the appropriate
credentials, qemu binary was linked with same librbd as running one.
Does anyone have a suggestion?
