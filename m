From: Willem Jan Withagen <wjw-dOtk1Lsa4IaEVqv0pETR8A@public.gmane.org>
Subject: Re: librados for MacOS
Date: Thu, 3 Aug 2017 10:41:13 +0200
Message-ID: <a9353d6a-0404-e17a-0331-7281c6ff39ea@digiware.nl>
References: <CANMxC7BAMJRxGPazPaUCQMs1b6SGjF2JRHG2B7KoEUBnrHUiMQ@mail.gmail.com>
	<CAF-wwdHN+No6edidKYD4iFjy1ui9bdm=1jRkftrjewJ4aDxyFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAF-wwdHN+No6edidKYD4iFjy1ui9bdm=1jRkftrjewJ4aDxyFg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: nl
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Brad Hubbard <bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Martin Palma <martin-0Gz4coKHHX0@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On 03/08/2017 09:36, Brad Hubbard wrote:
> On Thu, Aug 3, 2017 at 5:21 PM, Martin Palma <martin-0Gz4coKHHX0@public.gmane.org> wrote:
>> Hello,
>>
>> is there a way to get librados for MacOS? Has anybody tried to build
>> librados for MacOS? Is this even possible?
> 
> Yes, it is eminently possible, but would require a dedicated effort.
> 
> As far as I know there is no one working on this atm.

Looking at the code I've come across a few #ifdef's for OSX and sorts.
So attempts have been tried, but I think that code has rotted.
Now FreeBSD and MacOS have a partial similar background, so ATM I would
expect a MacOS port not to be all complex. And build on some of the
stuff I've done for FreeBSD. Not sure if the native compiler on Mac is
Clang, but all Clang issues are already fixed. (If Clang on Mac is at
least at 3.8)

Liek Btad says:It does require persistence, and testing. But most
important, it will also require maintenance.

--WjW
