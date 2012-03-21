From: Borodin Vladimir <v.a.borodin@gmail.com>
Subject: Theoretical questions
Date: Wed, 21 Mar 2012 12:22:58 +0300
Message-ID: <CAGEBRh0t-X4-HE5-nyFbAmW7-k+yj7d4FjhiZL_WhQ6CjPToew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46613 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932168Ab2CUJW7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Mar 2012 05:22:59 -0400
Received: by iagz16 with SMTP id z16so1324746iag.19
        for <ceph-devel@vger.kernel.org>; Wed, 21 Mar 2012 02:22:58 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all.

I've read everything in ceph.newdream.net/docs and
ceph.newdream.net/wiki. I've also read some articles from
ceph.newdream.net/publications. But I haven't found answers on some
questions:
1. there is one active MDS and one in standby mode. Active MDS caches
all metadata in RAM. Does standby MDS copy this information to RAM?
Will it take metadata from OSDs on every request after primary MDS
failure? Do read requests come to standby MDS?
2. what replication strategy on OSDs (primary-copy, chain or splay) is
turned on by default?
3. when does kernel client understand that the write was successfull
(when it recieves ack or commit from primary OSD)?
4. I want to have 3 copies of each object. By default there is a way
to write only one successfull copy (and two others give a failure),
isn't that? Is there a way to turn this off (even if one of three
copies failed, the object will be placed to another PG)?
5. if I have several data centers with good network connection, what
is the way to provide data locality? For example, most of write and
read requests from Spain come to Spanish DC and most of write and read
requests from Russia come to Russian DC. Is it posible?

Regards,
Vladimir.
