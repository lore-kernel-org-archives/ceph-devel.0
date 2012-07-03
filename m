From: Gregory Farnum <greg@inktank.com>
Subject: Re: Throughput increase by LACP bonding
Date: Tue, 3 Jul 2012 08:18:53 -0700
Message-ID: <8C571BF2075A4A28BEAB913A27D14C6D@inktank.com>
References: <loom.20120703T093148-928@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39954 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756460Ab2GCPS6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 11:18:58 -0400
Received: by pbbrp8 with SMTP id rp8so9381006pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 03 Jul 2012 08:18:58 -0700 (PDT)
In-Reply-To: <loom.20120703T093148-928@post.gmane.org>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Madhusudhana U <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tuesday, July 3, 2012 at 12:42 AM, Madhusudhana U wrote:
> Hi all,
> I am trying to increase the throughput in the cluster by enabling
> LACP on both in clients and all ceph cluster nodes. Each client and =20
> ceph nodes has two 1G Ethernet interface which I want to aggregate
> and make it 2G. LACP has been configured at switch side too. But even=
 after
> the configuration, I am not seeing any through put increase in ceph t=
ell osd
> bench command and also dd. They are taking the same amount as earlier=
=2E I am =20
> constantly seeing around 100MB/sec throughput in both DD and ceph ben=
ch =20
> commands. Can someone suggest me how i can increase the throughput of=
 the
> cluster ? Below are my configurations.
> =20
> No of OSD's : 5
> No of MON's : 3
> No of MDS's : 2
> Linux Kernel : 3.4.4
> Ceph version : 0.47.3
> Hard disks : 2x160G SAS drives (raid 0 configuration)
> CPU : Intel(R) Xeon(R) Quad CPU E5506 @ 2.13GHz
> Memory : 6G

Apart from what's already been mentioned about checking your configurat=
ion, keep in mind the osd bench is entirely a local test =E2=80=94 if i=
t says 100MB/s, that means your OSD disk can do 100MB/s, and increasing=
 the network connectivity isn't going to change that. :)

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
