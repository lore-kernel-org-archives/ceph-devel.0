From: Matt Weil <mweil@genome.wustl.edu>
Subject: Re: active MDS and disk write cache
Date: Wed, 31 Oct 2012 15:07:01 -0500
Message-ID: <509184E5.1000705@genome.wustl.edu>
References: <50915991.3030906@genome.wustl.edu> <5091839A.9060305@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from gscsmtp.wustl.edu ([128.252.233.26]:51843 "HELO
	gscsmtp.wustl.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759728Ab2JaUHD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 16:07:03 -0400
In-Reply-To: <5091839A.9060305@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sam Lang <sam.lang@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


>
> Hi Matt,
>
> Can you post your ceph config?  Once you startup your ceph cluster, you
> see that linuscs92 is the standby and linuscs95 is the active?  How are
> you starting your cluster?
>
service ceph -a start

and yes linuscs95 comes out as active.


[global]
	; enable secure authentication
;	auth supported = cephx
;	log_to_syslog = true
;	keyring = /etc/ceph/keyring.bin
	; monitors
	;  You need at least one.  You need at least three if you want to
	;  tolerate any node failures.  Always create an odd number.
	journal dio = true
	osd op threads = 24
	osd disk threads = 24
	filestore op threads = 6
	filestore queue max ops = 24

	osd client message size cap = 14000000
	ms dispatch throttle bytes =  17500000

[mon]
	mon data = /vol/disk2/data/mon$id
	; some minimal logging (just message traffic) to aid debugging
;	debug ms = 1

[mon.0]
	host = linuscs92
	mon addr = 10.0.30.10:6789

#[mon.1]
#	host = linuscs93
#	mon addr = 10.0.30.11:6789

[mon.1]
	host = linuscs95
	mon addr = 10.0.30.13:6789

	; mds
	;  You need at least one.  Define two to get a standby.

[mds]
	; where the mds keeps its secret encryption keys
;	keyring = /etc/ceph/keyring.$name

[mds.linuscs92]
	host = linuscs92

[mds.linuscs95]
	host = linuscs95
	mds standby replay = true
	mds standby for name = linuscs92

#[mds.linuscs94]
#    host = linuscs94

	; osd
	;  You need at least one.  Two if you want data to be replicated.
	;  Define as many as you like.

[osd]
	osd journal size = 1024
;	keyring = /etc/ceph/keyring.$name

[osd.0]
	host = linuscs92
	osd data = /vol/disk2/data/osd$id
	osd journal = /vol/disk1/data/osd$id/journal

[osd.1]
	host = linuscs93
	osd data = /vol/disk2/data/osd$id
	osd journal = /vol/disk1/data/osd$id/journal
	
[osd.2]
	host = linuscs94
	osd data = /vol/disk2/data/osd$id
	osd journal = /vol/disk1/data/osd$id/journal
	
[osd.3]
	host = linuscs95
	osd data = /vol/disk2/data/osd$id
	osd journal = /vol/disk1/data/osd$id/journal
	
[osd.4]
	host = linuscs96
	osd data = /vol/disk2/data/osd$id
	osd journal = /vol/disk1/data/osd$id/journal

[osd.5]
	host = linuscs97
	osd data = /vol/disk2/data/osd$id
	osd journal = /vol/disk1/data/osd$id/journal


