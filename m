From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: [PATCH v2 2/2] ceph: quota: fix quota subdir mounts
Date: Mon, 18 Mar 2019 16:49:40 +0530
Message-ID: <CAJ4mKGZKUO5DYrn7-PaD=rqERx1rywGmiTyyAaSd=f9dBumzBA@mail.gmail.com>
References: <20190312142019.30936-1-lhenriques@suse.com> <20190312142019.30936-3-lhenriques@suse.com>
 <CAAM7YAmMBv1Z4Etp5yf9K=RqpTNF0kJ3tsiAysfs_wv9mdNG8w@mail.gmail.com>
 <CAJ4mKGZ3a9xq4HkR3JQ0yRyBCh1acm0YEz14OBUK+bQFzbVEDg@mail.gmail.com>
 <CAAM7YAmt+OS8=ycPrtLLe_FqeD2F_szdkShNAPA49FOPoJd+Gg@mail.gmail.com> <87lg1czc26.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87lg1czc26.fsf@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hendrik Peyerl <hpeyerl@plusline.net>
List-Id: ceph-devel.vger.kernel.org

On Mon, Mar 18, 2019 at 4:25 PM Luis Henriques <lhenriques@suse.com> wrote:
>
> "Yan, Zheng" <ukernel@gmail.com> writes:
>
> > On Mon, Mar 18, 2019 at 5:06 PM Gregory Farnum <gfarnum@redhat.com> wrote:
> >>
> >> On Mon, Mar 18, 2019 at 2:32 PM Yan, Zheng <ukernel@gmail.com> wrote:
> >> > After reading the code carefully. I feel a little uncomfortable with
> >> > the "lookup_ino" in get_quota_realm.  how about populating directories
> >> > above the 'mount subdir' during mounting (similar to cifs_get_root ).
>
> Wouldn't it be a problem if the directory layout (or, in this case, the
> snaprealm layout) change during the mount lifetime?  In that case we
> would need to do this lookup anyway.
>
> >>
> >> Isn't that going to be a problem for any clients which have
> >>restricted filesystem access permissions? They may not be able to see
> >>all the directories above their mount point.  -Greg
> >
> > using lookup_ino to get inode above the "mount subdir" has the same problem
> >
>
> In this case I believe we get an -EPERM from the MDS.  And then the
> client simply falls back to the 'default' behaviour, which is to allow
> the user to create/write to files as if there were no quotas set.

Right, but a client is a lot more likely to have access to
/home/<username>/ than they are to also be able to look at /, and
/home.

So if they can do a lookup on /home/<username>/ they get their quota,
but if they have to look it up from the root it's lost even though the
client has permission to see all the things that contain their quota
state... :/

>
> Cheers,
> --
> Luis
