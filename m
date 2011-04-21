From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: libceph API
Date: Thu, 21 Apr 2011 10:35:45 -0700
Message-ID: <BANLkTi=DB7sqb9aHmigGiQZWzFAp-jugAA@mail.gmail.com>
References: <BANLkTim22eFcMzxL0sB4GRpUZfu7FL3x4A@mail.gmail.com>
	<Pine.LNX.4.64.1104202200100.26241@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63812 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755148Ab1DURfr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Apr 2011 13:35:47 -0400
Received: by fxm17 with SMTP id 17so1065802fxm.19
        for <ceph-devel@vger.kernel.org>; Thu, 21 Apr 2011 10:35:46 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1104202200100.26241@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, Brian Chrisman <brchrisman@gmail.com>

On Wed, Apr 20, 2011 at 10:03 PM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 20 Apr 2011, Colin McCabe wrote:
>> Hi guys,
>>
>> I pushed a branch with a revised libceph API. The main changes:
>>
>> * similar appearance to librados. It should be intuitive if you've
>> used librados.
>> * The new API allows multiple ceph clusters to be open at once
>> (although the implementation doesn't support this yet)
>> * ability to pass a "root" argument to ceph_mount
>> * add support for reading configuration files and choosing whether t=
o parse argv
>> * simpler ceph_getcwd
>> * unmount can't fail (the library always cleans up after itself)
>>
>> The branch is at
>> http://ceph.newdream.net/git/?p=3Dceph.git;a=3Dshortlog;h=3Drefs/hea=
ds/libceph_api
>>
>> Let me know what you think!
>
> Can we combine the ceph_connect() and ceph_mount() into one thing? =A0=
Does
> that make sense? =A0If so, maybe it should be ceph_mount_t and not
> ceph_cluster_t or something.

Good idea.

>
> The (re/ab)use of DIR* was possibly not the wisest choice in the orig=
inal
> API (and Client.h for that matter?). =A0Now might be the time to use =
a more
> reasonably named typedef.

Looking at client/Client.cc, it seems to be using DIR* as a kind of
opaque pointer. Not a good call, because DIR is not opaque to anyone
who has included dirent.h.

I'll try replacing it with libceph_dir_t* or something like that.

>
> A few of the methods can probably go away (things like ceph_mkdirs) o=
r be
> cleaned up (the layout get/set stuff).

Looks like Hadoop and Hypertable are using mkdirs. Hadoop doesn't seem
to have a "regular" mkdir... looks like everything is created via the
equivalent of mkdir -p. Maybe that is a good enough reason to keep it?
I don't know.

The get/set functions for layout do seem to need a cleanup. There's no
getter for default_file_strip_count, for one thing. Also the names
don't seem to quite match between the getters and setters, which
doesn't help.

sincerely,
Colin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
