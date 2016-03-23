From: Chris Dunlop <chris-s239Etu9j1dPR4JQBCEnsQ@public.gmane.org>
Subject: Re: v0.94.6 Hammer released
Date: Wed, 23 Mar 2016 14:37:16 +1100
Message-ID: <20160323033716.GA5156@onthe.net.au>
References: <20160310000006.GA14061@onthe.net.au>
	<20160316232029.GA22451@onthe.net.au>
	<011EEA5C-6A6B-489B-AB20-6EDEE2F55AFE@ebay.com>
	<20160317014314.GA25617@onthe.net.au>
	<20160322224923.GA31017@onthe.net.au>
	<56F1D1D3.8070207@dachary.org>
	<20160322233932.GA32084@onthe.net.au>
	<56F1DD3A.4000902@dachary.org> <20160323001200.GA1244@onthe.net.au>
	<56F1E1D5.4080006@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56F1E1D5.4080006-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Loic Dachary <loic-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org>
Cc: Wei-Chung Cheng <freeze.vicente.cheng-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sage Weil <sage-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Chen, Xiaoxi" <xiaoxchen-ZuctOmHWJ9c@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, Mar 23, 2016 at 01:22:45AM +0100, Loic Dachary wrote:
> On 23/03/2016 01:12, Chris Dunlop wrote:
>> On Wed, Mar 23, 2016 at 01:03:06AM +0100, Loic Dachary wrote:
>>> On 23/03/2016 00:39, Chris Dunlop wrote:
>>>> "The old OS'es" that were being supported up to v0.94.5 includes debian
>>>> wheezy. It would be quite surprising and unexpected to drop support for an
>>>> OS in the middle of a stable series.
>>>
>>> I'm unsure if wheezy is among the old OS'es. It predates my involvement in the stable releases effort. I know for sure el6 and 12.04 are supported for 0.94.x. 
>> 
>> From http://download.ceph.com/debian-hammer/pool/main/c/ceph/
>> 
>> ceph-common_0.94.1-1~bpo70+1_i386.deb              15-Dec-2015 15:32            10217628
>> ceph-common_0.94.3-1~bpo70+1_amd64.deb             19-Oct-2015 18:54             9818964
>> ceph-common_0.94.4-1~bpo70+1_amd64.deb             26-Oct-2015 20:48             9868020
>> ceph-common_0.94.5-1~bpo70+1_amd64.deb             15-Dec-2015 15:32             9868188
>> 
>> That's all debian wheezy.
>> 
>> (Huh. I'd never noticed 0.94.1 was i386 only!)
>> 
> 
> Indeed. Were these packages created as a lucky side effect or because there was a commitment at some point ? I'm curious to know the answer as well :-)

Who would know?  Sage?  (cc'ed)

Chris
