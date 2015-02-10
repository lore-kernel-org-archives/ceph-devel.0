From: Gregory Farnum <greg@gregs42.com>
Subject: Re: [ceph-commit] branch master updated. v0.92-935-g541a8f7
Date: Tue, 10 Feb 2015 12:54:35 -0800
Message-ID: <CAC6JEv-au+jvL_+eY5_iqmXaNF6fP8XOS+7=nXF4Ya-is0peyw@mail.gmail.com>
References: <20150208102251.39A01416D4@ds3287.dreamservers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36851 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbbBJUyg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Feb 2015 15:54:36 -0500
Received: by ierx19 with SMTP id x19so21471704ier.3
        for <ceph-devel@vger.kernel.org>; Tue, 10 Feb 2015 12:54:36 -0800 (PST)
Received: from mail-ie0-f181.google.com (mail-ie0-f181.google.com. [209.85.223.181])
        by mx.google.com with ESMTPSA id i20sm39405igh.16.2015.02.10.12.54.35
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Feb 2015 12:54:35 -0800 (PST)
Received: by iebtr6 with SMTP id tr6so27850449ieb.4
        for <ceph-devel@vger.kernel.org>; Tue, 10 Feb 2015 12:54:35 -0800 (PST)
In-Reply-To: <20150208102251.39A01416D4@ds3287.dreamservers.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Haomai,

On Sun, Feb 8, 2015 at 2:22 AM, ceph.git <ceph-commit@ceph.com> wrote:
> This is an automated email from the git hooks/post-receive script. It=
 was
> generated because a ref change was pushed to the repository containin=
g
> the project "".
>
> The branch, master has been updated
>        via  541a8f735523808b076b15bac5b063d0671faeee (commit)
>        via  d2eaeea081a729f9c5b4fb0386c717a21becdb1d (commit)
>        via  f9114114dc05b0b371fa3d4b87516f1bebf08216 (commit)
>        via  c252e05a51523f35eea17355ffc19737db1e47d9 (commit)
>        via  2b6b100a9b61e908c745c70c6d0ccb196a4e1bd7 (commit)
>       from  f2de124a20030367162641237f782c0a1d55fb82 (commit)
>
> Those revisions listed above that are new to this repository have
> not appeared on any other notification email; so we list those
> revisions in full, below.
>
> - Log ---------------------------------------------------------------=
--
> commit 541a8f735523808b076b15bac5b063d0671faeee
> Merge: f2de124 d2eaeea
> Author: Sage Weil <sage@redhat.com>
> Date:   Sun Feb 8 02:21:33 2015 -0800
>
>     Merge pull request #3665 from yuyuyu101/wip-fix-qa
>
>     AsyncConnection: Fix several bugs from qa test
>
>     Reviewed-by: Sage Weil <sage@redhat.com>
>
> commit d2eaeea081a729f9c5b4fb0386c717a21becdb1d
> Author: Haomai Wang <haomaiwang@gmail.com>
> Date:   Sun Feb 8 15:47:39 2015 +0800
>
>     AsyncConnection: fix incorrect condition for exchanging in_seq
>
>     Originally we use "in_seq=3D=3D0" to judge whether need to exchan=
ge in_seq,
>     it's wrong when peer side already receive message and need to rep=
ly new
>     in_seq to this side.
>
>     Now use "is_reset_from_peer" to indicate whether not need to exch=
ange
>
>     Signed-off-by: Haomai Wang <haomaiwang@gmail.com>
>
> commit f9114114dc05b0b371fa3d4b87516f1bebf08216
> Author: Haomai Wang <haomaiwang@gmail.com>
> Date:   Thu Feb 5 10:48:00 2015 +0800
>
>     NetHandler: Lower connect failed log level
>
>     Signed-off-by: Haomai Wang <haomaiwang@gmail.com>
>
> commit c252e05a51523f35eea17355ffc19737db1e47d9
> Author: Haomai Wang <haomaiwang@gmail.com>
> Date:   Thu Feb 5 10:40:35 2015 +0800
>
>     AsyncConnection: fixup for 2ffacbe (crc configuration in messenge=
r)
>
>     Learn from commit d5d1e27d9190463f484f896456ae6a9b5ea15cf8
>
>     Signed-off-by: Haomai Wang <haomaiwang@gmail.com>
>
> commit 2b6b100a9b61e908c745c70c6d0ccb196a4e1bd7
> Author: Haomai Wang <haomaiwang@gmail.com>
> Date:   Thu Feb 5 02:06:55 2015 +0800
>
>     AsyncConnection: Don't delete event if fd < 0
>
>     Signed-off-by: Haomai Wang <haomaiwang@gmail.com>
>

<snip>

> +class FakeEvent : public EventCallback {
> +
> + public:
> +  void do_request(int fd_or_id) {}
> +};
> +
> +TEST(EventCenterTest, FileEventExpansion) {
> +  vector<int> sds;
> +  EventCenter center(g_ceph_context);
> +  center.init(100);
> +  EventCallbackRef e(new FakeEvent());
> +  for (int i =3D 0; i < 10000; i++) {
> +    int s =3D ::socket(AF_INET, SOCK_STREAM, 0);
> +    center.create_file_event(i, EVENT_READABLE, e);
> +    sds.push_back(::socket(AF_INET, SOCK_STREAM, 0));
> +  }
> +
> +  for (vector<int>::iterator it =3D sds.begin(); it !=3D sds.end(); =
++it)
> +    center.delete_file_event(*it, EVENT_READABLE);
> +}
> +
>  INSTANTIATE_TEST_CASE_P(
>    AsyncMessenger,
>    EventDriverTest,

This is popping up a warning on the gitbuilders because the variable
"s" is unused. I went to provide a quick fix and realized I don't know
what the fix should be =E2=80=94 it looks like this test creates two so=
ckets
on every event and tosses out the first one for some reason. Is it
supposed to be doing something else? :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
