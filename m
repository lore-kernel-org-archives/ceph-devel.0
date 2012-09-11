From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Access Dienied for bucket upload - 403 code
Date: Tue, 11 Sep 2012 14:55:34 -0700
Message-ID: <CAC-hyiFy62RzF_z+YUVqbeFnMYwJ0Nqs4D2cq1HFkQaWM7u3qg@mail.gmail.com>
References: <CAMwB3Tg6L1F8bg_DJ9g0ySGn5hjJsiCW0DmKANodrHbESpVqfg@mail.gmail.com>
	<CAC-hyiGYPJpMCLhW6t00ysxXYovAnsnztaxO8LL-dQLtgfbYUQ@mail.gmail.com>
	<CAC-hyiGo2D1oErBx3B3n9Vr=vT_R9L0qQ80vuuHKO_1gjbVPYg@mail.gmail.com>
	<CAMwB3TiPiwBCwwnFKZFeMAwKKAzc0rVWHKHoc9vnqkTXZL1P7w@mail.gmail.com>
	<CAMwB3ThhS5Y=GP259HTJbNDZudLmSVaCqD4jgWdhvQXCygPGcw@mail.gmail.com>
	<CAC-hyiGF4yt1vewrZQNNcrqvCJJZBWMTukefq5BDBuYR7U1CEg@mail.gmail.com>
	<CAMwB3Tjg-Oyb9CRMDWY8EXCNfTC9aB6w=qGOC=Rz5O0yfn27YA@mail.gmail.com>
	<CAC-hyiFiL4yX75NNLPEaxt6XbLZj5YLnzi5Fk5oidUwy2ooGPw@mail.gmail.com>
	<CAMwB3Th5wjGeQsDxv2aCXvwsUk-hw_-_Cs+WyvwpbN9N1wGdiw@mail.gmail.com>
	<CAC-hyiF--FVokkNNO0mzWr3sFJL0xqv5h6uZKrzW3TQX-3rXpQ@mail.gmail.com>
	<CAMwB3Th06AF=BigLifBusJQZXj7+HOS_D3JcwYjj9sVjGyMw3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:58689 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870Ab2IKVzf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Sep 2012 17:55:35 -0400
Received: by eekc1 with SMTP id c1so804373eek.19
        for <ceph-devel@vger.kernel.org>; Tue, 11 Sep 2012 14:55:34 -0700 (PDT)
In-Reply-To: <CAMwB3Th06AF=BigLifBusJQZXj7+HOS_D3JcwYjj9sVjGyMw3Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Sep 11, 2012 at 2:50 PM, S=C5=82awomir Skowron <szibis@gmail.co=
m> wrote:
> Ehh my ideas run out for this day.
>
> libs3                            2.0-1
>
> s3 -u create foo
>
> Bucket successfully created.
>
> s3 -u getacl foo | s3 -u setacl ocdn < /tmp/acl

Hmm.. I had a typo

# s3 -u getacl foo | s3 -u setacl ocdn
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
