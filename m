From: David Galloway <dgallowa@redhat.com>
Subject: Re: success-comment of github pr trigger
Date: Wed, 1 Nov 2017 12:11:30 -0400
Message-ID: <07f40898-ef71-95da-806d-1187b6986647@redhat.com>
References: <CAJE9aOMiVa8SeXJ3Jd5Jyj0agLsoo=SMcu==ypj-i=yC2xQinQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754593AbdKAQLe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 1 Nov 2017 12:11:34 -0400
In-Reply-To: <CAJE9aOMiVa8SeXJ3Jd5Jyj0agLsoo=SMcu==ypj-i=yC2xQinQ@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Alfredo Deza <adeza@redhat.com>

On 11/01/2017 01:48 AM, kefu chai wrote:
> hi Alfredo,
> 
> i found that jenkins started to comment on PRs when completing a job.
> for example, see
> https://github.com/ceph/ceph/pull/18659#issuecomment-340964973. this
> is a little bit annoying and distracting. but i checked
> https://github.com/ceph/ceph-build/blob/master/ceph-pull-requests/config/definitions/ceph-pull-requests.yml#L39,
> we don't specify the success-comment there. i wonder it might be jjb?
> but i checked the jjb 2.0.0.0b2, it looks sane. see
> https://github.com/openstack-infra/jenkins-job-builder/blob/04348c2c00657490b4712ae61c6a1bed691a3e3a/jenkins_jobs/modules/triggers.py#L1122.
> do you have any idea off the head? are we experimenting some new
> features?
> 


I suspect something in GitHub's API changed and the Github Pull Request
Builder plugin is behind/out of date.

Starting at Nov 01, 2017 2:57:31 AM UTC, ghprb started to indicate it
was failing to update PR statuses (although I don't think it was) and
started sending comments.

"Use comments to report results when updating commit status fails" was
checked in the Jenkins settings.  I've unchecked it so hopefully the
comments will stop for now.

Please let me know if that's not the case.
