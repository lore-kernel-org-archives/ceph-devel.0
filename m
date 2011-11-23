From: Kelly Kane <kelly@hawknetworks.com>
Subject: Re: Why Ceph's aggregate write throughput does not scale with the
 number of osd nodes
Date: Wed, 23 Nov 2011 14:33:38 -0800
Message-ID: <CAKfXD0x=ujYL9mr09tQzc2UZp4QRszEPyJWp3a+e01dYvsXufA@mail.gmail.com>
References: <CAND_vCaQU5hFk++6mMnS7MwnAoY2_c-xxe3pEbjJsGQuAsaeiQ@mail.gmail.com>
	<CAF3hT9AqbhPDrBmeymTvBO_FZp5FF2VmwyPeh_cQFFgsi-L96A@mail.gmail.com>
	<CAND_vCZTuOmq3LMJ7eqc8jtbc7Yv7e9YSqy6=cTwGtjBsZ+rfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61308 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755021Ab1KWWdj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Nov 2011 17:33:39 -0500
Received: by ywt32 with SMTP id 32so1888909ywt.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 Nov 2011 14:33:39 -0800 (PST)
In-Reply-To: <CAND_vCZTuOmq3LMJ7eqc8jtbc7Yv7e9YSqy6=cTwGtjBsZ+rfA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaofei Du <xiaofei.du008@gmail.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

On Wed, Nov 23, 2011 at 12:07, Xiaofei Du <xiaofei.du008@gmail.com> wrote:
>
> I installed Ceph on 10 ec2 instances.

Can you go into more detail about your EC2 instances and where you are
storing your data? If you are storing them on standard EBS then you
are competing for non-guaranteed bandwidth. The information contained
on the AWS product description page is basically a lie (
http://aws.amazon.com/ebs/ ) unless things have changed substantially
since I last used them.  If you are storing data on the ephemeral
disks then unless you are on a "whole machine" instance
(m1.xlarge/c1.xlarge/m2.4xlarge) you are competing for SATA resources
on the ephemeral disks. If your machine neighbors are doing some heavy
disk workload you may simply be starved for resources.

Kelly
