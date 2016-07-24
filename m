From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Ceph fix for 4.7-rc8
Date: Sun, 24 Jul 2016 10:09:47 +0900
Message-ID: <CA+55aFw3Yf+Yzc9W6iFMTh=HONMASc8ecfTm2+cLHAV9RxQZKQ@mail.gmail.com>
References: <1469288067-21830-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1469288067-21830-1-git-send-email-idryomov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Sun, Jul 24, 2016 at 12:34 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
>
> The tag is signed with a brand new key - Sage is on vacation and
> I didn't anticipate this.  Hopefully that's not a no-no.

Hmm. Not only is the signing key new, you apparently haven't even
pushed out the key to the usual pgp key servers, so I can't even see
if it has any good signatures on it.

The patch look s reasonable, so I've pulled it, but can you please:

 (a) get your new key signed by somebody if it isn't already

 (b) make sure it's actually synced to some pgp keyserver ("gpg
--send-keys 0211F38B" or similar)

 (c) send me email when that is done so that I can update my keyring.

Thanks,

         Linus
