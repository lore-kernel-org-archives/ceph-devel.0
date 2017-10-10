From: Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: killing ceph-disk [was Re: ceph-volume: migration
 and disk partition support]
Date: Tue, 10 Oct 2017 08:21:35 -0400
Message-ID: <CAC-Np1wLx-fqJ2kJv9TT0Hny520bCLZAcen=8rTU0zsS-zGJhQ@mail.gmail.com>
References: <CAC-Np1xUasg0C34HEuCFims18zPyRZ17p9-mp3xYCUETAYnn_A@mail.gmail.com>
 <alpine.DEB.2.11.1710091448500.26711@piezo.us.to>
 <20171010095014.64940afa@batzmaru.gol.ad.jp>
 <CAC-Np1yBe3_mTzLvMfxvO+0CW20p1txjVwL2zg6ACqu6L1s7iQ@mail.gmail.com>
 <a1c7e8df-44a1-a03f-ddbc-2bb66494256a@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <a1c7e8df-44a1-a03f-ddbc-2bb66494256a-dOtk1Lsa4IaEVqv0pETR8A@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Willem Jan Withagen <wjw-dOtk1Lsa4IaEVqv0pETR8A@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, Oct 10, 2017 at 8:14 AM, Willem Jan Withagen <wjw-dOtk1Lsa4IaEVqv0pETR8A@public.gmane.org> wrote:
> On 10-10-2017 13:51, Alfredo Deza wrote:
>> On Mon, Oct 9, 2017 at 8:50 PM, Christian Balzer <chibi-FW+hd8ioUD0@public.gmane.org> wrote:
>>>
>>> Hello,
>>>
>>> (pet peeve alert)
>>> On Mon, 9 Oct 2017 15:09:29 +0000 (UTC) Sage Weil wrote:
>>>
>>>> To put this in context, the goal here is to kill ceph-disk in mimic.
>
> Right, that means we need a ceph-volume zfs before things get shot down.
> Fortunately there is little history to carry over.
>
> But then still somebody needs to do the work. ;-|
> Haven't looked at ceph-volume, but I'll put it on the agenda.

An interesting take on zfs (and anything else we didn't set up from
the get-go) is that we envisioned developers might
want to craft plugins for ceph-volume and expand its capabilities,
without placing the burden of coming up
with new device technology to support.

The other nice aspect of this is that a plugin would get to re-use all
the tooling in place in ceph-volume. The plugin architecture
exists but it isn't fully developed/documented yet.

>
> --WjW
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
