From: John Axel Eriksson <john@insane.se>
Subject: Re: cephx auth question
Date: Tue, 12 Jun 2012 12:05:56 +0200
Message-ID: <CAMmJxtLGhgtBUmShHyZDQmgqzKvkzgjjWxK-Atp220mziK67iA@mail.gmail.com>
References: <CAMmJxtJViXYznfRuzMqJsvWZ7YEghkgD2HUhHZ9h4AyaXFz+cA@mail.gmail.com>
	<4FD7116B.9030003@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55639 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905Ab2FLKF5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jun 2012 06:05:57 -0400
Received: by obbtb18 with SMTP id tb18so8097070obb.19
        for <ceph-devel@vger.kernel.org>; Tue, 12 Jun 2012 03:05:56 -0700 (PDT)
In-Reply-To: <4FD7116B.9030003@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

Ok I think I have a better understanding now.

I really don't want to setup a cluster using mkcephfs, it "feels" like
that's something built for test setups. If I(and I do) want to
automate the setup of OSDs, MONs and RGW it definitely makes it more
complicated using key based auth. I've seen the chef recipes but I'm
not sure they're complete in any way.

I don't entirely understand if there is an order to the setup, if I
have to partly setup the MON first, then OSDs, then configure the MON,
then configure the OSDs and lastly configure RGW. If that's the case
it's kind of complicated and adding keys into the mix doesn't help.

I guess giving more time to my ceph-research will help me get a better
understanding of the auth parts and the rest. I'll have to be less
impatient ;-).

Thanks for responding,

John

On Tue, Jun 12, 2012 at 11:52 AM, Wido den Hollander <wido@widodh.nl> w=
rote:
> Hi,
>
>
> On 06/12/2012 11:31 AM, John Axel Eriksson wrote:
>>
>> I asked a similar question in a previous email but I didn't get any
>> satisfying answers. What exactly does cephx auth secure?
>
>
> I wanted to get back on your e-mail from yesterday, but you beat me t=
o it!
> :)
>
>
>> =A0From the wiki I just get "this makes your cluster more secure", w=
ell
>> from what? If I run on an internal network accessible only
>> by a few trusted people - what does cephx auth secure in such a scen=
ario?
>>
>
> Never ever trust anything, even in a local network. Security has more
> aspects then just uninvited guests accessing or modifying your data.
>
> Like I said in the previous e-mail, it prevents you from having an ol=
d
> machine or just a plain configuration error on a client disrupting cl=
uster
> service.
>
>
>> In that previous email I got the answer that it secures the cluster
>> from mistakenly connecting to wrong cluster with rados and
>> accidentally deleting a pool... well, can rados really "accidentally=
"
>> connect to the wrong cluster? Only if I have the wrong config
>> file right? And if I have the wrong config-file won't it be possible
>> that I also have the "wrong" key in that case?
>>
>
> The "rados" command doesn't really need a config file, you can also s=
pecify
> the monitor address manually.
>
> $ rados -p <mon address> rmpool data
>
> If you'd issue that with the wrong monitor address while playing in y=
our
> local network you could remove the pool on the wrong cluster.
>
> With cephx in place you also have to specify the correct key, it's ju=
st a
> second layer in place from preventing something like this happening.
>
>
>> Another scenario would be if I take down an OSD that just sits in
>> storage for say 6 months and then someone starts that machine
>> again - with key-based auth that OSD wouldn't be able to
>> connect(somehow? but if it has a working key?) but without auth it
>> could
>> possibly connect and wreak havoc in the cluster (since it is so much
>> behind perhaps in both version of software and what's stored on it).
>> I thought marking and OSD as down or out would do that?
>>
>
> If you mark an OSD out it will get marked as "in" again when you star=
t up
> the OSD, but that also depends on your settings like "noautoin".
>
> When you take an OSD out of production with cephx you would also remo=
ve the
> corresponding OSD key from the cluster keyring.
>
>
>> Are those the main reasons for having cephx auth? Is it to secure th=
e
>> cluster against people (myself included) making mistakes or =A0from
>> hacking, or is there some technical reason that I don't know of or
>> understand?
>>
>
> It can serve multiple purposes. In a bigger env you should never trus=
t any
> machine. So if you have a client which only has access to the "rbd" p=
ool for
> running Virtual Machines, it shouldn't get more permissions than that=
=2E
>
> So yes, it's again human error, but if a machine gets hacked, you can
> prevent that machine from ruining your whole cluster.
>
>
>> The reason I'm asking is because having cephx enabled makes cluster
>> setup much more complicated...
>>
>
> cephx might be complicated at first glance, but it isn't really that =
hard.
>
> It is up to you if you enable it, but take the recommendations above =
into
> account when making your decision.
>
> Wido
>
>>
>> Thanks,
>>
>> John
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
