From: =?UTF-8?B?5pSA5YiY?= <liupan1111@gmail.com>
Subject: vstart.sh failed
Date: Fri, 11 Aug 2017 17:46:41 +0800
Message-ID: <CAMwhyqW=1ghYXwBYX+P+prqL-1e=w1YJQneeRg6_=arMC+ePvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:36849 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751521AbdHKJqm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Aug 2017 05:46:42 -0400
Received: by mail-vk0-f43.google.com with SMTP id u133so11521035vke.3
        for <ceph-devel@vger.kernel.org>; Fri, 11 Aug 2017 02:46:42 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi All,

I am trying to use vstart.sh to create a local cluster, and got the
problem below, could anybody give me some help? Thanks!

.....
set mgr/restful/x/server_port
Starting mgr.x
/mnt/aliceph/liupan1/ceph/build/bin/ceph-mgr -i x -c
/mnt/aliceph/liupan1/ceph/build/ceph.conf
/mnt/aliceph/liupan1/ceph/build/bin/ceph -c
/mnt/aliceph/liupan1/ceph/build/ceph.conf -k
/mnt/aliceph/liupan1/ceph/build/keyring restful
create-self-signed-cert
no valid command found; 10 closest matches:
osd setcrushmap {<int>}
osd crush set {<int>}
osd crush rule dump {<name>}
osd crush dump
osd crush rule list
osd crush rule ls
osd blacklist ls
osd blacklist clear
osd map <poolname> <objectname> {<nspace>}
osd lspools {<int>}
Error EINVAL: invalid command
MGR Restful is not working, perhaps the package is not installed?
started.  stop.sh to stop.  see out/* (e.g. 'tail -f out/????') for
debug output.
