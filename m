From: Howard Chu <hyc@symas.com>
Subject: Re: Fwd: Fwd: [newstore (again)] how disable double write WAL
Date: Mon, 22 Feb 2016 17:17:22 +0000
Message-ID: <56CB42A2.1090901@symas.com>
References: <9D046674-EA8B-4CB5-B049-3CF665D4ED64@aevoo.fr>
 <alpine.DEB.2.00.1511241240150.25734@cobra.newdream.net>
 <CA+gn+znHyioZhOvuidN1pvMgRMOMvjbjcues_+uayYVadetz=A@mail.gmail.com>
 <CA+gn+z=5+gu=3R3ssLq-kQBjB6DFYeb9JteXV5Y7in89b8cmKA@mail.gmail.com>
 <alpine.DEB.2.00.1512011357340.19170@cobra.newdream.net>
 <5661F3A9.8070703@redhat.com> <20151208044640.GL1983@devil.localdomain>
 <CA+gn+znGzF+J=qAk+511qdfPJV4xYB+4F5k8KMLWh0+JtryLeA@mail.gmail.com>
 <20160216033538.GB2005@devil.localdomain> <56C74B91.9080508@redhat.com>
 <CA+gn+znGy7VnfkZ+vz65s-j+hpTafQ731-T_tx6gYZrRk3h1Yw@mail.gmail.com>
 <56CB2FCB.8080105@redhat.com>
 <CA+gn+z=7N+uaNXQ3DU65ZFiNhW-VPjwf+ppaMLxswgoep5EJ3g@mail.gmail.com>
 <56CB346B.50200@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from zill.ext.symas.net ([69.43.206.106]:58628 "EHLO
	zill.ext.symas.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376AbcBVRsn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Feb 2016 12:48:43 -0500
Received: from cust230-77.nwewn.com ([78.155.230.77] helo=[192.168.1.204])
	by zill.ext.symas.net with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <hyc@symas.com>)
	id 1aXu6y-0004nR-JZ
	for ceph-devel@vger.kernel.org; Mon, 22 Feb 2016 09:17:29 -0800
In-Reply-To: <56CB346B.50200@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

(Just as an aside on the Subject - in preliminary testing with a run of the 
mill 32GB microSD card, LMDB on a raw partition performs synchronous commits 
~8x faster than the same card formatted with an ext4 filesystem. There's a 
huge cost to journaling filesystems that a reliable database engine simply 
doesn't need.)

-- 
   -- Howard Chu
   CTO, Symas Corp.           http://www.symas.com
   Director, Highland Sun     http://highlandsun.com/hyc/
   Chief Architect, OpenLDAP  http://www.openldap.org/project/
