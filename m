From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: force pushes disabled for master in ceph.git and ceph-deploy.git
Date: Wed, 10 Dec 2014 15:33:25 -0700
Message-ID: <5488CA35.1040908@redhat.com>
References: <5488C747.2000003@redhat.com> <5488C861.1080005@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48570 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932724AbaLJWec (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 10 Dec 2014 17:34:32 -0500
In-Reply-To: <5488C861.1080005@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, ceph-devel@vger.kernel.org

On 12/10/2014 03:25 PM, Loic Dachary wrote:
> On 10/12/2014 23:20, Ken Dreyer wrote:
>> Thanks to GitHub Support, force-pushes are now disabled for master in
>> ceph.git and ceph-deploy.git. This should save us from accidentally
>> deleting history with a bad force-push to the wrong branch. (Not that
>> any of us were going to do that, of course! :)
> 
> Thanks ! I did that last year and that makes me appreciate the precaution ;-)

Whoops, so I duplicated your work apparently!

I was thinking that we should do this for the release branches as well?
So "argonaut", "bobtail", "cuttlefish" "dumpling", "emperor", "firefly",
"giant"... any other branches?

And should we open a new support request each time we create a new
release branch in the future?

- Ken
