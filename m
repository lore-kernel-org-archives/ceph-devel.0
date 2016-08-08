From: Sebastien Han <shan@redhat.com>
Subject: Re: [Feature request] config diff on a single option with the admin socket
Date: Mon, 8 Aug 2016 14:16:56 +0200
Message-ID: <CA+HUO7+QVu-HqBT7EuuEoLwPVng84HzG_MmbvMQyueEstR-6Gw@mail.gmail.com>
References: <CA+HUO7+qxtsS03yKp2ETUhKy6WTX1ESd0Xridw13viWwa0Cj3Q@mail.gmail.com>
 <alpine.LSU.2.20.1607291125130.28641@ancalagon.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37459 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbcHHMRT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Aug 2016 08:17:19 -0400
Received: by mail-wm0-f47.google.com with SMTP id i5so135093519wmg.0
        for <ceph-devel@vger.kernel.org>; Mon, 08 Aug 2016 05:17:18 -0700 (PDT)
In-Reply-To: <alpine.LSU.2.20.1607291125130.28641@ancalagon.suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jesse Williamson <jwilliamson@suse.de>
Cc: Squid Cybernetic <ceph-devel@vger.kernel.org>

Would be nice if you could get a stab at it, actually I don't know
where to look in the code to see where the magic is happening for the
admin socket.
Most of the logic is there so this shouldn't be too difficult :).

Did you get a chance to look into this Jesse?
Thanks for offering your help on this one!

On Fri, Jul 29, 2016 at 8:32 PM, Jesse Williamson <jwilliamson@suse.de> wrote:
> On Fri, 29 Jul 2016, Sebastien Han wrote:
>
> Hi Sebastien,
>
>> I'd like to have the same but for a specific option only.
>>
>> So something like:
>>
>> ceph daemon mon.ceph-mon-01 config diff get <field>
>>
>> Which will return the diff between the actual config value and the
>> original config value.
>
>
> I might be able to help with this, if there's no support that anyone already
> knows of, or clear takers. I'm working on a small config-related librados
> feature right now and am somewhat familiar with the relevant moving parts on
> that end, so I might be in a good position to work on it.
>
> WRT the admin socket, I'm less clear, but can be pointed in the right
> direction. :-)
>
> -Jesse



-- 
Cheers

––––––
Sébastien Han
Principal Storage Architect

"Always give 100%. Unless you're giving blood."

Mail: seb@redhat.com
Address: 11 bis, rue Roquépine - 75008 Paris
