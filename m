From: Venkateswara Rao Jujjuri <jujjuri@gmail.com>
Subject: Help with CEPH deployment
Date: Sat, 2 May 2015 13:58:23 -0700
Message-ID: <CAKKTCLVJJA04BuymLiONYKmJELGpbPp776g=btF1ha4TRhHR-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34072 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945968AbbEBU6o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 2 May 2015 16:58:44 -0400
Received: by oiko83 with SMTP id o83so90123045oik.1
        for <ceph-devel@vger.kernel.org>; Sat, 02 May 2015 13:58:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

Started to install basic cluster from scratch, but running into keyring issues.
Basically /etc/ceph/ceph.client.admin.keyring is not getting generated
on monitor node.
When I tried to create it on the monitor node, it fails with:

$ ceph auth get-or-create client.admin mon 'allow *' mds 'allow *' osd
'allow *' -o /etc/ceph/ceph.client.admin.keyring
2015-05-02 12:32:59.198588 7f0e30395700 -1 monclient(hunting): ERROR:
missing keyring, cannot use cephx for authentication
2015-05-02 12:32:59.198592 7f0e30395700  0 librados: client.admin
initialization error (2) No such file or directory
Error connecting to cluster: ObjectNotFound


$ ceph --version
ceph version 0.94.1 (e4bfad3a3c51054df7e537a724c8d0bf9be972ff)


Following these insructions:

http://docs.ceph.com/docs/master/start/quick-ceph-deploy/

Failing at :

$ ceph-deploy  mon create-initial
because it could not find /etc/ceph/ceph.client.admin.keyring

Help appreciated.
-- 
Jvrao
---
First they ignore you, then they laugh at you, then they fight you,
then you win. - Mahatma Gandhi
