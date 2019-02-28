From: Igor Fedotov <ifedotov-l3A5Bk7waGM@public.gmane.org>
Subject: Re: ceph osd commit latency increase over time,
 until restart
Date: Fri, 1 Mar 2019 01:01:58 +0300
Message-ID: <c051fcb9-9c8c-32bd-7835-2182fade8d14@suse.de>
References: <395511117.2665.1548405853447.JavaMail.zimbra@oxygem.tv>
 <2062110719.174905.1549294821422.JavaMail.zimbra@oxygem.tv>
 <d4558d4b-b1c9-211a-626a-0c14df3e29b9@suse.de>
 <825077993.841032.1549638894023.JavaMail.zimbra@oxygem.tv>
 <2132634351.842536.1549641461010.JavaMail.zimbra@oxygem.tv>
 <c26e0eca-1a1c-3354-bff6-4560e3aea4c5@suse.de>
 <1554220830.1076801.1550047328269.JavaMail.zimbra@oxygem.tv>
 <f97b81e4-265d-cd8e-3053-321d988720c4@suse.de>
 <19368722.1223708.1550237472044.JavaMail.zimbra@odiso.com>
 <056c13b4-fbcf-787f-cfbe-bb37044161f8@42on.com>
 <20190228205705.GB31731@shell.dmz.bit.nl>
 <392d66bb-5647-9b19-c17b-5259f4ed6749@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <392d66bb-5647-9b19-c17b-5259f4ed6749-l3A5Bk7waGM@public.gmane.org>
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
To: Stefan Kooman <stefan-68+x73Hep80@public.gmane.org>, Wido den Hollander <wido-fspyXLx8qC4@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Also I think it makes sense to create a ticket at this point. Any 
volunteers?

On 3/1/2019 1:00 AM, Igor Fedotov wrote:
> Wondering if somebody would be able to apply simple patch that 
> periodically resets StupidAllocator?
>
> Just to verify/disprove the hypothesis it's allocator relateted
>
> On 2/28/2019 11:57 PM, Stefan Kooman wrote:
>> Quoting Wido den Hollander (wido-fspyXLx8qC4@public.gmane.org):
>>> Just wanted to chime in, I've seen this with Luminous+BlueStore+NVMe
>>> OSDs as well. Over time their latency increased until we started to
>>> notice I/O-wait inside VMs.
>> On a Luminous 12.2.8 cluster with only SSDs we also hit this issue I
>> guess. After restarting the OSD servers the latency would drop to normal
>> values again. See https://owncloud.kooman.org/s/BpkUc7YM79vhcDj
>>
>> Reboots were finished at ~ 19:00.
>>
>> Gr. Stefan
>>
