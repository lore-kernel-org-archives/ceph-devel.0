From: Hunter Nield <hunter@acale.ph>
Subject: Re: Consul
Date: Wed, 5 Nov 2014 17:28:57 +0800
Message-ID: <CAGRK8cy0yPo8b1V9s3++BiMZP4eWkmcjqn1h1Ad00PKsCbGMHA@mail.gmail.com>
References: <54597169.2040006@dachary.org> <CAGRK8cwq0WkSG98mavGRe4vFzwyK9dqTrgc9knQaE2n0e-YGjg@mail.gmail.com>
 <5459E1EE.90509@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:56417 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbaKEJ3T convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Nov 2014 04:29:19 -0500
Received: by mail-qc0-f174.google.com with SMTP id r5so204166qcx.19
        for <ceph-devel@vger.kernel.org>; Wed, 05 Nov 2014 01:29:18 -0800 (PST)
In-Reply-To: <5459E1EE.90509@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Nov 5, 2014 at 4:38 PM, Loic Dachary <loic@dachary.org> wrote:
> I guess using radosgw with the S3/Swift API is close enough in terms of what Consul needs to store key/values. But maybe I don't understand what you mean by "easily accessible distributed KV store" and wrongly assume radosgw is easy enough ;-)

Yes, we did consider RGW. We were originally looking for something
simpler for internal use. More than librados but less than a full
object storage gateway. We didn't need Apache or multi-tenant
authentication, just somewhere to store keys and pull them out
elsewhere. Closer to clustered Memcache or Redis. Consul provides most
of that now and adds a few things like locks and long polling

>> On a side note, I haven't spoken to Dan in a while but curious on his
>> thoughts on the overlap on Consul in config management land. Service
>> discovery, remote execution, etc have some overlap in Puppet, Chef,
>> etc. Related to Ceph we're pondering it as alternative for deploying
>> mons/osds (larger scale ceph-deploy perhaps)
>
> Is there a framework for integration tests of some kind in Consul ? Although https://github.com/puppetlabs/beaker/ provides that for puppet, it is still rarely used and it is painful because even when used to develop a module, it is likely to break in unpredictable ways because module dependencies have no integration tests and suffer from frequent regressions. It would be great to see modern tools such as Consul encourage a more robust approach to integration tests with proper tooling from the start.

I'm not entirely sure about integration tests. Certainly there are
unit tests for the code but there doesn't seem to be much (that I can
see) about testing things like external health checks or remote exec.
