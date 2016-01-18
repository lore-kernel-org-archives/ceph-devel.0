From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Asserts while running test/erasure-code/test-erasure-eio.sh
Date: Mon, 18 Jan 2016 20:38:52 +0100
Message-ID: <569D3F4C.9090900@digiware.nl>
References: <569BC209.2000600@digiware.nl>
 <CAJ4mKGbCjXt5MxxpvMVXoJcTUuCvgzCzzhh+9v7+p+qhvS9pQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:35154 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755979AbcARTjG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 18 Jan 2016 14:39:06 -0500
In-Reply-To: <CAJ4mKGbCjXt5MxxpvMVXoJcTUuCvgzCzzhh+9v7+p+qhvS9pQA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 18-1-2016 19:37, Gregory Farnum wrote:
> On Sunday, January 17, 2016, Willem Jan Withagen <wjw@digiware.nl
> <mailto:wjw@digiware.nl>> wrote:
> 
> 
>     When I run the above script I get asserts:
> 
>     osd/ECBackend.cc: 201: FAILED assert(res.errors.empty())
> 
>     Which is in this code:
>     struct OnRecoveryReadComplete :
>       public GenContext<pair<RecoveryMessages*,
>     ECBackend::read_result_t& > &> {
>       ECBackend *pg;
>       hobject_t hoid;
>       set<int> want;
>       OnRecoveryReadComplete(ECBackend *pg, const hobject_t &hoid)
>         : pg(pg), hoid(hoid) {}
>       void finish(pair<RecoveryMessages *, ECBackend::read_result_t &>
>     &in) {
>         ECBackend::read_result_t &res = in.second;
>         // FIXME???
>         assert(res.r == 0);
>         assert(res.errors.empty());
>         assert(res.returned.size() == 1);
>         pg->handle_recovery_read_complete(
>           hoid,
>           res.returned.back(),
>           res.attrs,
>           in.first);
>       }
>     };
> 
>     Now the //FIXME remark suggests that the code could be not oke.
>     And/or the asserts are too strong.
>     Any hints, suggestions or questions to fix this.
> 
> 
> I haven't checked the code in any detail, but this snippet is asserting
> that we didn't get any errors while reading several different chunks of
> an erasure-coded data stripe. The FIXME is because it would be great if
> we could handle errors transparently, but if the make check tests are
> failing, presumably there's an issue.

Hi Greg,

Thanx for the info.
In that case it is something that goes onto my list of things to solve.

Perhaps even the upgrade to Clang 3.8 (I saw commits passing by FreeBSD
11.0) helps... Upgrading stuff changed some of the errors the previous
time, did not fix 'm but made a lot more sense.

--WjW


