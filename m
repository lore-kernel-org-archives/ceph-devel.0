From: Anthony D'Atri <aad-lmG3kWHAawoohuQDye/k0w@public.gmane.org>
Subject: Re: rgw,
 nss: dropping the legacy PKI token support in RadosGW (removed in
 OpenStack Ocata)
Date: Fri, 19 Apr 2019 11:39:55 -0700
Message-ID: <4DF8AE6D-2A41-4FEB-B5A5-C4AA88CEF1E6@dreamsnake.net>
References: <CAB-Rz_XgtSahmo=+bx5rPPWPrXwPNDTq22i6KppybgqMeMCrUw@mail.gmail.com>
 <alpine.DEB.2.11.1904191222130.7074@piezo.novalocal>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1904191222130.7074-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org


I've been away from OpenStack for a couple of years now, so this may have changed.  But back around the Icehouse release, at least, upgrading between OpenStack releases was a major undertaking, so backing an older OpenStack with newer Ceph seems like it might be more common than one might think.

Which is not to argue for or against dropping PKI in Ceph, but if it's going to be done, please call that out early in the release notes to avoid rude awakenings.


> [Adding ceph-users for better usability]
> 
> On Fri, 19 Apr 2019, Radoslaw Zarzynski wrote:
>> Hello,
>> 
>> RadosGW can use OpenStack Keystone as one of its authentication
>> backends. Keystone in turn had been offering many token variants
>> over the time with PKI/PKIz being one of them. Unfortunately,
>> this specific type had many flaws (like explosion in size of HTTP
>> header) and has been dropped from Keystone in August 2016 [1].
>> By "dropping" I don't mean just "deprecating". PKI tokens have
>> been physically eradicated from Keystone's code base not leaving
>> documentation behind. This happened in OpenStack Ocata.
>> 
>> Intuitively I don't expect that brand new Ceph is deployed with
>> an ancient OpenStack release. Similarly, upgrading Ceph while
>> keeping very old OpenStack seems quite improbable.
> 
> This sounds reasonable to me.  If someone is running an old OpenStack, 
> they should be able to defer their Ceph upgrade until OpenStack is 
> upgraded... or at least transition off the old keystone variant?
> 
> sage
> 
>> If so, we may consider dropping PKI token support in further
>> releases. What makes me perceive this idea as attractive is:
>> 1) significant clean-up in RGW. We could remove a lot of
>> complexity including the entire revocation machinery with
>> its dedicated thread.
>> 2) Killing the NSS dependency. After moving the AWS-like
>> crypto services of RGW to OpenSSL, the CMS utilized by PKI
>> token support is the library sole's user.
>> I'm not saying it's a blocker for NSS removal. Likely we could
>> reimplement the stuff on top of OpenSSL as well.
>> All I'm worrying about is this can be futile effort bringing
>> more problems/confusion than benefits. For instance, instead
>> of just dropping the "nss_db_path" config option, we would
>> need to replace it with counterpart for OpenSSL or take care
>> of differences in certificate formats between the libraries.
>> 
>> I can see benefits of the removal. However, the actual cost
>> is mysterious to me. Is the feature useful?
>> 
>> Regards,
>> Radek
>> 
>> [1]: https://github.com/openstack/keystone/commit/8a66ef635400083fa426c0daf477038967785caf
>> 
>> 
