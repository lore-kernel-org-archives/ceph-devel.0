From: Andreas Bluemle <andreas.bluemle@itxperts.de>
Subject: Re: cephfs <fs> set_layout --pool_meta <SSD> --pool_data <SAS>
Date: Tue, 16 Jul 2013 14:26:21 +0200
Message-ID: <20130716142621.0de44e47@andylap>
References: <20130716115448.GA23760@oder.mch.fsc.net>
	<20130716115850.GA24975@oder.mch.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from port-212-202-108-184.static.qsc.de ([212.202.108.184]:47974
	"EHLO mail.itxperts.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932095Ab3GPM0Z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jul 2013 08:26:25 -0400
In-Reply-To: <20130716115850.GA24975@oder.mch.fsc.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kasper Dieter <dieter.kasper@ts.fujitsu.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hallo Dieter,

Kein Fehler, sondern ein fehlendes Kommando.
Ein neuer pool muss dem mds erst bekannt gemacht werden.
     ceph mds add_data_pool <pool number>

Siehe Mitschnitt unten.

Damit duerfte uebrigens auch meine Frage von gestern geloest
sein: die zugehoerigkeit zu einem bestimmten Pool kann 
fuer ein Verzeichnis und damit einen ganzen Baum vergeben
werden.

Mit freundlichen Gruessen

Andreas Bluemle

[root@rx37-2 ~]# cephfs /mnt/cephfs/pool3 set_layout -s 4194304 \
                      -c 1 -u 4194304 -p 6
Error setting layout: Invalid argument

[root@rx37-2 ~]# ceph mds add_data_pool 6
added data pool 6 to mdsmap

[root@rx37-2 ~]# cephfs /mnt/cephfs/pool3 set_layout -s 4194304 \
                      -c 1 -u 4194304 -p 6
[root@rx37-2 ~]# cephfs /mnt/cephfs/pool3 show_layout
layout.data_pool:     6
layout.object_size:   4194304
layout.stripe_unit:   4194304
layout.stripe_count:  1



On Tue, 16 Jul 2013 13:58:50 +0200
Kasper Dieter <dieter.kasper@ts.fujitsu.com> wrote:

> BTW is there are a solution to put Cephfs metadata on a pool
> 'SSD-group' and Cephfs data on a 2nd pool 'SAS-group' ?
> 
> Regards,
> Dieter Kasper
> 
> 
> On Tue, Jul 16, 2013 at 01:54:48PM +0200, Kasper Dieter wrote:
> > I followed the description
> > http://www.sebastien-han.fr/blog/2013/02/11/mount-a-specific-pool-with-cephfs/
> > ... to change the pool assigned to cephfs:
> > 
> > # ceph osd dump | grep rule
> > pool 0 'data' rep size 2 min_size 1 crush_ruleset 0 object_hash
> > rjenkins pg_num 10304 pgp_num 10304 last_change 1 owner 0
> > crash_replay_interval 45 pool 1 'metadata' rep size 2 min_size 1
> > crush_ruleset 1 object_hash rjenkins pg_num 10304 pgp_num 10304
> > last_change 1 owner 0 pool 2 'rbd' rep size 2 min_size 1
> > crush_ruleset 2 object_hash rjenkins pg_num 10304 pgp_num 10304
> > last_change 1 owner 0 pool 3 'SSD-group-2' rep size 2 min_size 1
> > crush_ruleset 3 object_hash rjenkins pg_num 3300 pgp_num 3300
> > last_change 299 owner 0 pool 4 'SSD-group-3' rep size 3 min_size 1
> > crush_ruleset 3 object_hash rjenkins pg_num 3300 pgp_num 3300
> > last_change 302 owner 0 pool 5 'SAS-group-2' rep size 2 min_size 1
> > crush_ruleset 4 object_hash rjenkins pg_num 3300 pgp_num 3300
> > last_change 306 owner 0 pool 6 'SAS-group-3' rep size 3 min_size 1
> > crush_ruleset 4 object_hash rjenkins pg_num 3300 pgp_num 3300
> > last_change 309 owner 0
> > 
> > # cephfs /mnt/cephfs/ show_layout
> > layout.data_pool:     0
> > layout.object_size:   4194304
> > layout.stripe_unit:   4194304
> > layout.stripe_count:  1
> > 
> > # mount | grep ceph
> > 10.10.38.13:/ on /mnt/cephfs type ceph (name=admin,key=client.admin)
> > 
> > # cephfs /mnt/cephfs/ set_layout -p 3 -u 4194304 -c 1 -s 4194304
> > Error setting layout: Invalid argument
> > 
> > 
> > Is this a bug in the current release ?
> > # ceph -v
> > ceph version 0.61.4 (1669132fcfc27d0c0b5e5bb93ade59d147e23404)
> > 
> > How can this issue be solved ?
> > 
> > 
> > Kind Regards,
> > Dieter Kasper
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 



-- 
Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
Heinrich Boell Strasse 88           Phone: (+49) 89 4317582
D-81829 Muenchen (Germany)          Mobil: (+49) 177 522 0151
