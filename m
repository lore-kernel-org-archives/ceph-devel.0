From: Gregory Farnum <greg@inktank.com>
Subject: Re: 0.55 init script Issue?
Date: Wed, 5 Dec 2012 12:39:23 -0800
Message-ID: <CAPYLRzjme=UxScsKDXdKPAWJyfxB1hNQGRJWT7QyJk+ET3dFHQ@mail.gmail.com>
References: <50BF7314.2020809@gammacode.com>
	<50BFA354.7040308@inktank.com>
	<50BFABE5.1020904@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:40054 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963Ab2LEUqu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Dec 2012 15:46:50 -0500
Received: by mail-ie0-f179.google.com with SMTP id k14so8587527iea.10
        for <ceph-devel@vger.kernel.org>; Wed, 05 Dec 2012 12:46:50 -0800 (PST)
In-Reply-To: <50BFABE5.1020904@ubuntu.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Page <james.page@ubuntu.com>, Sage Weil <sage@inktank.com>
Cc: Dan Mick <dan.mick@inktank.com>, Mike Dawson <mdawson@gammacode.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Dec 5, 2012 at 12:17 PM, James Page <james.page@ubuntu.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> On 05/12/12 19:41, Dan Mick wrote:
>> The story as best I know it is that we're trying to transition to
>> and use upstart where possible, but that the upstart config does
>> not (yet?) try to do what the init.d config did.  That is, it
>> doesn't support options to the one script, but rather separates
>> daemons into separate services, and does not reach out to remote
>> machines to start daemons, etc.
>>
>> The intent is that init.d/ceph is left for non-Upstart distros,
>> AFAICT.
>>
>> Tv had some design notes here:
>>
>> http://www.mail-archive.com/ceph-devel@vger.kernel.org/msg09314.html
>>
>>  We need better documentation/rationale here at least.
>
> Maybe it might be better if the ceph init script and the ceph upstart
> configuration did not namespace clash; how about shifting the name of
> the ceph upstart configuration to ceph-all?

Yeah, this or something very similar is definitely the correct
solution. Sage recently added the "ceph" upstart job, and we didn't
put it through sufficient verification prior to release in order to
notice this issue. Users who aren't using upstart (I expect that's all
of them) should just delete the job after running the package install.
We'll certainly sort this out prior to the next release; I'm not sure
if we want to roll a v0.55.1 right away or not.
-Greg
