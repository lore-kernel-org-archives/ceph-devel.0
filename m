From: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Subject: Re: Symbolic links like feature on radosgw
Date: Tue, 3 Nov 2015 09:15:50 -0800
Message-ID: <CADRKj5TsGLXSJ4VFMdBPrwS4fORaqGPS0KnYFj8sUM-7U_3O0A@mail.gmail.com>
References: <CAKtk8hcvWJmdYmY20ZQsUuE=ww+Q=pDv6=HRVJhZ6Hk01U3wSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:33094 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbbKCRPv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Nov 2015 12:15:51 -0500
Received: by ykft191 with SMTP id t191so27107668ykf.0
        for <ceph-devel@vger.kernel.org>; Tue, 03 Nov 2015 09:15:50 -0800 (PST)
In-Reply-To: <CAKtk8hcvWJmdYmY20ZQsUuE=ww+Q=pDv6=HRVJhZ6Hk01U3wSg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guang Yang <guangyy@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Yehuda Sadeh <yehuda@inktank.com>

On Mon, Nov 2, 2015 at 9:20 PM, Guang Yang <guangyy@gmail.com> wrote:
> Hi Yehuda,
> We have a user requirement that needs symbolic link like feature on radosgw
> - two object ids pointing to the same object (ideally it could cross bucket,
> but same bucket is fine).
>
> The closest feature on Amazon S3 I could find is [1], but not exact the
> same, the one from Amazon S3 API was designed for static web site hosting.
>
> Is this a valid feature request we can put into radosgw? The way I am
> thinking to implement is like symbolic link, the link object just contains a
> pointer to the original object.

Yeah, I don't see why not to have such a feature. Access to the
referral object can potentially have us return a redirect response, or
actually return the data. The latter is somewhat similar to swift
static large objects (with the slight difference that we only refer to
a single object here), for which we have a pending pull request open.
The redirect does look somehow like the static website feature, for
which we're also in a review process.
Probably extending the swift slo feature to be supported in S3, and
have add special api that will only have it point to a single object
is a good way to proceed. Later we can have it redirect if the object
that is referenced resides in a different region. Just sending a
redirect to everything will make it simpler, any reason to go with the
more complicated solution (performance is an obvious one)?

Yehuda

>
> [1] http://docs.aws.amazon.com/AmazonS3/latest/dev/how-to-page-redirect.html
>
> --
> Regards,
> Guang
