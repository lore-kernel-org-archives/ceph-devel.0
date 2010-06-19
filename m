From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: creation of ./.snap/test creates something in ./subdir/.snap/
Date: Sat, 19 Jun 2010 16:03:28 +0000 (UTC)
Message-ID: <hvipog$r1f$1@dough.gmane.org>
References: <hvhrh3$n0a$1@dough.gmane.org>
	<Pine.LNX.4.64.1006190833230.17737@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:52374 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756325Ab0FSQDj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 19 Jun 2010 12:03:39 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OQ0WA-00039Q-DU
	for ceph-devel@vger.kernel.org; Sat, 19 Jun 2010 18:03:38 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 19 Jun 2010 18:03:38 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 19 Jun 2010 18:03:38 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Sat, 19 Jun 2010 08:40:48 -0700 schrieb Sage Weil:

> On Sat, 19 Jun 2010, Thomas Mueller wrote:
>> hi
>> 
>> i was looking for a way to list all snapshots*.
>> 
>> then i discovered this:
>> 
>> 
>> mkdir ./.snap/test
>> 
>> then i found this:
>> ./.snap/test
>> ./subdir/.snap/_test_1099511630280
>> 
>> 
>> the subdir/.snap/_test_1099511630280 vanishes if i delete the ./.snap/
>> test.
> 
> This is expected, because subdir's contents are contained by the 'test'
> snap, and we want the .snap/ dir to show you all snaps that contain
> copies of the current directory.  The name is mangled
> (_$snap_$snap_root_ino) to avoid collisions with the current directory's
> snap namespace.  Snaps beginning with _ are disallowed.
> 


thanks for the explanation! i've created 

http://ceph.newdream.net/wiki/Snapshots

for future  reference. 

- Thomas


