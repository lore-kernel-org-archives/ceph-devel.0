From: "=?UTF-8?B?TGx1w61zIFDDoG1pZXMgaSBKdcOhcmV6?=" <llpamies@pamies.cat>
Subject: erasured PG always "peering"
Date: Wed, 12 Mar 2014 10:40:40 -0700
Message-ID: <CAKD2hyHsCTTLWtTR8O6GYMgk=qRw38r_JGz=vAY+yA1DonqYyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f47.google.com ([209.85.213.47]:42153 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbaCLRkl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Mar 2014 13:40:41 -0400
Received: by mail-yh0-f47.google.com with SMTP id 29so4858302yhl.20
        for <ceph-devel@vger.kernel.org>; Wed, 12 Mar 2014 10:40:41 -0700 (PDT)
Received: from mail-yk0-x22b.google.com (mail-yk0-x22b.google.com [2607:f8b0:4002:c07::22b])
        by mx.google.com with ESMTPSA id t58sm76121851yho.20.2014.03.12.10.40.40
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 12 Mar 2014 10:40:40 -0700 (PDT)
Received: by mail-yk0-f171.google.com with SMTP id q9so27907889ykb.2
        for <ceph-devel@vger.kernel.org>; Wed, 12 Mar 2014 10:40:40 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi ceph-devel,

I have been playing with the new erasure code functionality and I have
noticed that the erasure coded PG remains in "peering" state forever. I=
s
that normal?

I have a scenario with four servers each with two OSDs (total of eight
OSDs). Then I define the extra crush rule to get four different OSDs ac=
ross
hosts:

rule reedsol_ruleset {
    ruleset 1
    type erasure
    min_size 4
    max_size 4
    step take default
    step chooseleaf firstn 0 type host
    step emit
}

And create a simple pool by:
sudo ceph osd pool create cauchy 1 1 erasure erasure-code-plugin=3Djera=
sure
erasure-code-k=3D2 erasure-code-m=3D2 erasure-code-technique=3Dcauchy_g=
ood
crush_ruleset=3Dreedsol_ruleset

After that, the PG status jumps from "creating" to "peering" and stays
there forever. With "sudo ceph pg dump_stuck" I can see:

pg_stat objects mip degr unf bytes log disklog state state_stamp v repo=
rted
up up_primary acting acting_primary last_scrub scrub_stamp last_deep_sc=
rub
deep_scrub_stamp
5.0 0 0 0 0 0 0 0 peering 2014-03-12 10:30:36.717544 0'0 58:3 [0,6,2,5]=
 0
[0,6,2,5] 0 0'0 2014-03-12 10:30:36.715589 0'0 2014-03-12 10:30:36.7155=
89

I guess that this is not normal and I'm probably doing something wrong.=
 Any
ideas?

Thanks,
Llu=C3=ADs
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
