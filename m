From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 1/1 linux-next] ceph: use standard Opt_err
Date: Mon, 15 Jun 2015 12:30:42 +0300
Message-ID: <CAOi1vP9+_ZQi9kGhXzwxWm30MsYN9f0yucgXdigqxfOGWKAJWQ@mail.gmail.com>
References: <1433531567-3948-1-git-send-email-fabf@skynet.be>
	<CAOi1vP8Bm05VQFy-fcZmaZS9N=_k6WcfOK5D4Wpw3zgtwfVoBw@mail.gmail.com>
	<515133145.119252.1434272729936.open-xchange@webmail.nmp.proximus.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:32770 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243AbbFOJan (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Jun 2015 05:30:43 -0400
In-Reply-To: <515133145.119252.1434272729936.open-xchange@webmail.nmp.proximus.be>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fabian Frederick <fabf@skynet.be>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Sun, Jun 14, 2015 at 12:05 PM, Fabian Frederick <fabf@skynet.be> wrote:
>
>
>> On 08 June 2015 at 09:49 Ilya Dryomov <idryomov@gmail.com> wrote:
>>
>>
>> On Fri, Jun 5, 2015 at 10:12 PM, Fabian Frederick <fabf@skynet.be> wrote:
>> > ceph used -1 for the last match_table_t option.
>> > Use Opt_err enum like other FS
>> >
>> > match_token() is based on the pattern (NULL)
>> > so behavior should remain the same.
>> >
>> > Signed-off-by: Fabian Frederick <fabf@skynet.be>
>> > ---
>> > This is untested. If this one is ok, I can send the same update
>> > for rbd and net/ceph.
>> >
>> >  fs/ceph/super.c | 5 +++--
>> >  1 file changed, 3 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/fs/ceph/super.c b/fs/ceph/super.c
>> > index 4e99053..35ef692 100644
>> > --- a/fs/ceph/super.c
>> > +++ b/fs/ceph/super.c
>> > @@ -137,7 +137,8 @@ enum {
>> >  #ifdef CONFIG_CEPH_FS_POSIX_ACL
>> >         Opt_acl,
>> >  #endif
>> > -       Opt_noacl
>> > +       Opt_noacl,
>> > +       Opt_err
>> >  };
>> >
>> >  static match_table_t fsopt_tokens = {
>> > @@ -169,7 +170,7 @@ static match_table_t fsopt_tokens = {
>> >         {Opt_acl, "acl"},
>> >  #endif
>> >         {Opt_noacl, "noacl"},
>> > -       {-1, NULL}
>> > +       {Opt_err, NULL}
>> >  };
>> >
>> >  static int parse_fsopt_token(char *c, void *private)
>>
>> This would result in a BUG on any unknown option - match_token->token
>> is what match_token() returns and parse_fsopt_token() clearly expects
>> that to be a negative value.
>>
>> Thanks,
>
> Maybe we could remove the following test ?
>
> token = match_token((char *)c, fsopt_tokens, argstr);
> if (token < 0)
>         return -EINVAL;
>
> and return -EINVAL in switch default case ?

Sounds good.

Thanks,

                Ilya
