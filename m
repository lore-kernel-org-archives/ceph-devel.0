From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 1/1 linux-next] ceph: fix bool assignments
Date: Fri, 10 Oct 2014 12:24:36 +0400
Message-ID: <CALFYKtB8Z4HHr5ZuLcMdctOKBSZZjgCAhbOiFHgbPnVcbjLySw@mail.gmail.com>
References: <1412889395-19350-1-git-send-email-fabf@skynet.be>
	<54372B43.2010801@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54372B43.2010801@inktank.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Mick <dan.mick@inktank.com>, Julia Lawall <julia.lawall@lip6.fr>
Cc: Fabian Frederick <fabf@skynet.be>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sage Weil <sage@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Oct 10, 2014 at 4:41 AM, Dan Mick <dan.mick@inktank.com> wrote:
>
>
> On 10/09/2014 02:16 PM, Fabian Frederick wrote:
>> Fix some coccinelle warnings:
>> fs/ceph/caps.c:2400:6-10: WARNING: Assignment of bool to 0/1
>
>
>> -     bool wake = 0;
>> +     bool wake = false;
>
> FWIW, that message is backwards: it should say "WARNING: Assignment of
> 0/1 to bool" (I know, it's a coccinelle issue, but..)

Hi Julia,

See above, hopefully you are the right person to ask to forward this to
the right people ;)

Thanks,

                Ilya
