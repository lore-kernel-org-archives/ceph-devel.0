From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 03/47] block-rbd: Adjust the position of a jump label in rbd_header_from_disk()
Date: Tue, 13 Sep 2016 11:16:13 +0200
Message-ID: <CAOi1vP_XDRj9B-vAYVB=qN5Z-vbq75tYU1dFADRBz6P+J6V56Q@mail.gmail.com>
References: <566ABCD9.1060404@users.sourceforge.net> <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
 <71b06567-1ea9-204d-d61b-2af4426d9cd1@users.sourceforge.net>
 <CAOi1vP9iQ6u7dm0dRMg4rs6tLaR5mv55yew0URTX00-y6C0S6g@mail.gmail.com> <121f05b0-ac94-4d81-289e-9dc3668eab95@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <121f05b0-ac94-4d81-289e-9dc3668eab95@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, Jonathan Corbet <corbet@lwn.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Alex Elder <elder@kernel.org>, Sage Weil <sage@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Jean Delvare <jdelvare@suse.de>
List-Id: ceph-devel.vger.kernel.org

On Tue, Sep 13, 2016 at 10:12 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
>>> @@ -1064,7 +1064,7 @@ static int rbd_header_from_disk(struct rbd_device=
 *rbd_dev,
>>>         header->snap_sizes =3D snap_sizes;
>>>
>>>         return 0;
>>> -out_2big:
>>> + out_2big:
>>>         ret =3D -EIO;
>>>         kfree(snap_sizes);
>>>   free_names:
> =E2=80=A6
>> Can you point where this current convention is documented?
>
> Yes.
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/D=
ocumentation/CodingStyle?id=3D865a1caa4b6b886babdd9d67e7c3608be4567a51

Huh.  That patch is not in Linus' tree.

>
> Do you find the software update "CodingStyle: Clarify and complete chapte=
r 7" interesting?
>
>
>> Certainly not in CodingStyle, AFAICT...
>
> I suggest to look at the current version once more.
>
>
>> I know some people prefer a single space in there because it makes
>> "diff -p" work better, but nowadays with "git diff" this argument is
>> pretty moot.
>
> Would you like to discuss the corresponding software evolution a bit more=
?

Jon, could you please yank 865a1caa4b6b ("CodingStyle: Clarify and
complete chapter 7") from your linux-next branch or at least change "It
is advised to indent labels" to something less stronger?  It hasn't
even hit mainline yet and we are already getting spammed.

Looks like 9 out of 10 labels are not indented

$ git grep '^[a-z0-9]\+:' -- *.c | wc -l
27945
$ git grep '^ [a-z0-9]\+:' -- *.c | wc -l
2925

so I'd say that's a bad advise as far as consistency goes, and the
"diff -p" argument is pretty moot nowadays.

Thanks,

                Ilya
