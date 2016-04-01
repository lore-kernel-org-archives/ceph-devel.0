From: John Hunter <zhjwpku@gmail.com>
Subject: Re: [PATCH] ceph-disk: s/prefered/preferred/
Date: Fri, 1 Apr 2016 18:19:58 +0800
Message-ID: <CAEG8a3LwWTseTQ0y691AoBpQ_6RTVd6ji4761ASzDENp6FqnEQ@mail.gmail.com>
References: <56FE1B91.2080108@suse.cz>
	<56FE3A3E.3080008@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:34548 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143AbcDAKT7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Apr 2016 06:19:59 -0400
Received: by mail-yw0-f173.google.com with SMTP id d68so10865802ywe.1
        for <ceph-devel@vger.kernel.org>; Fri, 01 Apr 2016 03:19:59 -0700 (PDT)
In-Reply-To: <56FE3A3E.3080008@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Nathan Cutler <ncutler@suse.cz>, Ceph Development <ceph-devel@vger.kernel.org>

Is that from Linus?
I also think this is a good catch, there is no conflict AFAICS.
Is that because the patch description?

Reviewed-by: Zhao Junwang <zhjwpku@gmail.com>

On Fri, Apr 1, 2016 at 5:07 PM, Loic Dachary <loic@dachary.org> wrote:
> Once again, and with feeling: please PLEASE stop doing these idiotic =
things.
>
> You should worry about *your* code. Don't worry about my merge. Don't
> worry about other trees. Make sure YOUR code is well-tested and
> stable, and make sure there is absolutely nothing questionable there.
>
> This whole idiotic "let's rebase on top of something else because of =
a
> tiny conflict" is a disease.
>
> I'm simply not applying this. If you insist on sending me patches tha=
t
> have been rebased in the last day, then I will insist on just waiting
> for the next merge window.
>
> It really is that simple.
>
> This patch request came in very late in the merge window, and the cod=
e
> clearly has had almost zero actual testing since it was recently
> rebased.
>
> The fact that it avoids a merge conflict is not worth it.
>
> Stop doing this idiotic crazy thing. How many times do I have to tell
> people? When  you rebase, you are throwing your old testing away, and
> you're also making me get new commits that are different from the
> ceph-jewel commits.
>
> I'm not AT ALL interested in getting newly minted untested crap the
> last day of the merge window.
>
> Really.
>
>                    Loic
>
> On 01/04/2016 08:56, Nathan Cutler wrote:
>> Hi,
>>
>> Please pull the following Ceph updates from this mail.
>>
>> There is not much here, just some overdue proofreading.
>>
>> This patch is based on a recent merge of the jewel tree to avoid con=
flicts with a recent refactor.
>>
>> Sincerely
>>
>> Signed-off-by: Nathan Cutler <ncutler@suse.cz>
>> ---
>>  src/ceph-disk/ceph_disk/main.py | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/ceph-disk/ceph_disk/main.py b/src/ceph-disk/ceph_di=
sk/main.py
>> index d0ec596..a137967 100755
>> --- a/src/ceph-disk/ceph_disk/main.py
>> +++ b/src/ceph-disk/ceph_disk/main.py
>> @@ -406,7 +406,7 @@ def command(arguments, **kwargs):
>>      executable exists and raising a helpful error message
>>      if it does not.
>>
>> -    .. note:: This should be the prefered way of calling ``subproce=
ss.Popen``
>> +    .. note:: This should be the preferred way of calling ``subproc=
ess.Popen``
>>      since it provides the caller with the safety net of making sure=
 that
>>      executables *will* be found and will error nicely otherwise.
>>
>> @@ -429,7 +429,7 @@ def command_check_call(arguments):
>>      Safely execute a ``subprocess.check_call`` call making sure tha=
t the
>>      executable exists and raising a helpful error message if it doe=
s not.
>>
>> -    .. note:: This should be the prefered way of calling
>> +    .. note:: This should be the preferred way of calling
>>      ``subprocess.check_call`` since it provides the caller with the=
 safety net
>>      of making sure that executables *will* be found and will error =
nicely
>>      otherwise.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
