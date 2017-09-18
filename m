From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: Time to drop 11429.yaml from jewel?
Date: Mon, 18 Sep 2017 09:44:54 -0700
Message-ID: <342b2811-b4e7-9cd4-0b15-9c9ceee33ebd@redhat.com>
References: <86a21353-e714-df8c-9b31-3dbde91fe2f6@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52172 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932658AbdIRQoz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 18 Sep 2017 12:44:55 -0400
In-Reply-To: <86a21353-e714-df8c-9b31-3dbde91fe2f6@suse.cz>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Yuri Weinstein <yweinste@redhat.com>

On 09/18/2017 06:45 AM, Nathan Cutler wrote:
> Hi Josh:
> 
> rados/singleton-nomsgr/{all/11429.yaml rados.yaml} recently started to 
> fail in the jewel integration branch - here are the two most recent runs:
> 
> http://qa-proxy.ceph.com/teuthology/smithfarm-2017-09-12_17:11:54-rados-wip-jewel-backports-distro-basic-smithi/1623590/teuthology.log 
> 
> 
> http://qa-proxy.ceph.com/teuthology/smithfarm-2017-09-13_02:44:35-rados-wip-jewel-backports-distro-basic-smithi/1625890/teuthology.log 
> 
> 
> Could you help analyze these failures?

Looks like Kefu diagnosed them well on github - race-prone checks in the
test.

> I noticed that this test was dropped in the Infernalis development 
> cycle. Is it time to drop it in Jewel as well?

Yes, we certainly don't need any firefly-based tests at this point.

Josh
