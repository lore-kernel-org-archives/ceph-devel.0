From: Yehuda Sadeh <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: recreate bucket error
Date: Wed, 22 Jan 2014 08:25:23 -0800
Message-ID: <CABBk=J_x-vO+EJcne-fZyvp5W=6V8zh2deJZAVx_FK4Nd4xgfQ@mail.gmail.com>
References: <CAMNMNTzt_yPoqOhgKpi9vioAXygzD_oKzhHxsh-WA6NCB7mOcg@mail.gmail.com>
	<CABBk=J95C7OrwTAPN_EJ8dHmTOiSFExhrAv2n5FJ6RyACuMETA@mail.gmail.com>
	<CAMNMNTzd7LEht6y-5vT6sEvJeG3yErQGNGbmGM3x+hYOuTQs0g@mail.gmail.com>
	<CAC-hyiG9hznbysGs84_etew3BTbZwj3QoHVP66QCbCK9asoPgw@mail.gmail.com>
	<CAMNMNTz4pANPK67m0mLhYS=-GQpvRQ7DWCsQMjORvoM+7NPXrw@mail.gmail.com>
	<CABBk=J8b_UU7YhJUMwWhc8wjkv0a+dD3GAWySajJF1MwzJp_Sw@mail.gmail.com>
	<CAMNMNTxqyutv2r5d_AXgMiNRr15qCipsirajqB8xLf=MuDY2Rg@mail.gmail.com>
	<CAMNMNTwvZbbpX1H0UZiRvFb4YY0h9VXvuJryPBE9tqE6O1rbvQ@mail.gmail.com>
	<CABBk=J-RAb5dXZLU2F4heFu1VyoSnn9hxJ40_6UY8wXOOMBAdA@mail.gmail.com>
	<CAF6-1L71rADd59Pw4TRWNPJHCdwUyOTD2aN1k7+ax1RYy0g=+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAF6-1L71rADd59Pw4TRWNPJHCdwUyOTD2aN1k7+ax1RYy0g=+Q@mail.gmail.com>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Sylvain Munaut <s.munaut-IEbV4ISQ1OTUSxYbhEqsfVaTQe2KTcn/@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, Jan 22, 2014 at 2:33 AM, Sylvain Munaut
<s.munaut-IEbV4ISQ1OTUSxYbhEqsfVaTQe2KTcn/@public.gmane.org> wrote:
> Hi,
>
> On Sat, Dec 7, 2013 at 6:34 PM, Yehuda Sadeh <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:
>> Sounds like disabling the cache triggers some bug. I'll open a relevant ticket.
>
> Any news on this ?
>
> I have the same issue, but the cache only masks the problem. If you
> restart radosgw, you'll get it again (once for each bucket).
>

There's a related issue in the ceph tracker (#6951), and it's still up
on my list.

Yehuda
