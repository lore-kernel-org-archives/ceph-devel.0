From: Willem Jan Withagen <wjw-dOtk1Lsa4IaEVqv0pETR8A@public.gmane.org>
Subject: Re: killing ceph-disk [was Re: ceph-volume: migration
 and disk partition support]
Date: Tue, 10 Oct 2017 14:42:48 +0200
Message-ID: <61d1a237-90ad-04af-cf97-c314579e92a7@digiware.nl>
References: <CAC-Np1xUasg0C34HEuCFims18zPyRZ17p9-mp3xYCUETAYnn_A@mail.gmail.com>
 <alpine.DEB.2.11.1710091448500.26711@piezo.us.to>
 <20171010095014.64940afa@batzmaru.gol.ad.jp>
 <CAC-Np1yBe3_mTzLvMfxvO+0CW20p1txjVwL2zg6ACqu6L1s7iQ@mail.gmail.com>
 <a1c7e8df-44a1-a03f-ddbc-2bb66494256a@digiware.nl>
 <CAC-Np1wLx-fqJ2kJv9TT0Hny520bCLZAcen=8rTU0zsS-zGJhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAC-Np1wLx-fqJ2kJv9TT0Hny520bCLZAcen=8rTU0zsS-zGJhQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On 10-10-2017 14:21, Alfredo Deza wrote:
> On Tue, Oct 10, 2017 at 8:14 AM, Willem Jan Withagen <wjw-dOtk1Lsa4IaEVqv0pETR8A@public.gmane.org> wrote:
>> On 10-10-2017 13:51, Alfredo Deza wrote:
>>> On Mon, Oct 9, 2017 at 8:50 PM, Christian Balzer <chibi-FW+hd8ioUD0@public.gmane.org> wrote:
>>>>
>>>> Hello,
>>>>
>>>> (pet peeve alert)
>>>> On Mon, 9 Oct 2017 15:09:29 +0000 (UTC) Sage Weil wrote:
>>>>
>>>>> To put this in context, the goal here is to kill ceph-disk in mimic.
>>
>> Right, that means we need a ceph-volume zfs before things get shot down.
>> Fortunately there is little history to carry over.
>>
>> But then still somebody needs to do the work. ;-|
>> Haven't looked at ceph-volume, but I'll put it on the agenda.
> 
> An interesting take on zfs (and anything else we didn't set up from
> the get-go) is that we envisioned developers might
> want to craft plugins for ceph-volume and expand its capabilities,
> without placing the burden of coming up
> with new device technology to support.
> 
> The other nice aspect of this is that a plugin would get to re-use all
> the tooling in place in ceph-volume. The plugin architecture
> exists but it isn't fully developed/documented yet.

I was part of the original discussion when ceph-volume said it was going
to be plugable... And would be a great proponent of thye plugins.
If only because ceph-disk is rather convoluted to add to. Not that it
cannot be done, but the code is rather loaded with linuxisms for its
devices. And it takes some care to not upset the old code, even to the
point that code for a routine is refactored into 3 new routines: one OS
selctor and then the old code for Linux, and the new code for FreeBSD.
And that starts to look like a poor mans plugin. :)

But still I need to find the time, and sharpen my python skills.
Luckily mimic is 9 months away. :)

--WjW
