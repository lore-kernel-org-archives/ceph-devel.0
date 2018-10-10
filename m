From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] ceph: only allow punch hole mode in fallocate
Date: Wed, 10 Oct 2018 13:46:59 +0200
Message-ID: <CAOi1vP_YxCbb1aP=imNt6uJfEn18+kbG273mKW6A_+qQTnTA6A@mail.gmail.com>
References: <20181009175428.18543-1-lhenriques@suse.com> <CAAM7YAno0s5Z21jagvnFbQdkkwMOYadZG9trPvs4WKZLRLkLxg@mail.gmail.com>
 <CAOi1vP_HmqS3xgAdYSpQYhRg-2q6mhHEaRpQW2+-UyJs9K1UsQ@mail.gmail.com> <87sh1evyii.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87sh1evyii.fsf@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Wed, Oct 10, 2018 at 1:19 PM Luis Henriques <lhenriques@suse.com> wrote:
>
> Ilya Dryomov <idryomov@gmail.com> writes:
>
> > On Wed, Oct 10, 2018 at 6:21 AM Yan, Zheng <ukernel@gmail.com> wrote:
> >>
> >> On Wed, Oct 10, 2018 at 1:54 AM Luis Henriques <lhenriques@suse.com> wrote:
>
> <snip>
>
> >> Applied, thanks
> >
> > I don't think it should go to stable kernels.  Strictly speaking it's
> > a behaviour change -- it's been this way for many years and, unless you
> > are close to ENOSPC, it's sort of appears to work.  I'll take off the
> > stable tag unless I hear objections.
>
> Right, it can in fact break applications that rely on the previous
> (bogus) behaviour.  But it can also be claimed that it *will* break
> applications anyway with an updated kernel, so backporting it to older
> kernels will just allow a consistent behaviour.
>
> Anyway, I'm OK either way.  But if you drop the stable tag make sure you
> also remove the 'Fixes:' tag as I believe the stable folks will still
> pick this patch if it includes a valid SHA1 in it.

Yeah, we've run into this in the past.

Thanks,

                Ilya
