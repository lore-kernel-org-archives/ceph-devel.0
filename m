From: Varada Kari <Varada.Kari-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
Subject: Re: pools with latest master
Date: Mon, 18 Aug 2014 08:59:33 +0000
Message-ID: <C226B0AB34511445928D9882AA519F6005E90E31@SACMBXIP02.sdcorp.global.sandisk.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F26466DA8@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F26466DA8-cXZ6iGhjG0i+xgsn/SD5JjJ2aSJ780jGSxCzGc5ayCJWk0Htik3J/w@public.gmane.org>
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
To: Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Yes, these are recent changes from John. Because of these changes:


commit 90e6daec9f3fe2a3ba051301ee50940278ade18b
Author: John Spray <john.spray-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Date:   Tue Apr 29 15:39:45 2014 +0100

    osdmap: Don't create FS pools by default
    
    Because many Ceph users don't use the filesystem,
    don't create the 'data' and 'metadata' pools by
    default -- they will be created by newfs if
    they are needed.
    
    Signed-off-by: John Spray <john.spray-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>

commit 7294e8c4df6df9d0898f82bb6e0839ed98149310
Author: John Spray <john.spray-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Date:   Tue May 27 11:04:43 2014 +0100

    test/qa: update for MDSMonitor changes
    
    Accomodate changes:
     * data and metadata pools no longer exist by default
     * filesystem-using tests must use `fs new` to create
       the filesystem first.
    
    Signed-off-by: John Spray <john.spray-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>


Varada

From: ceph-users [mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] On Behalf Of Somnath Roy
Sent: Saturday, August 16, 2014 3:19 AM
To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: [ceph-users] pools with latest master

Hi, 
I have installed created a single node/single osd cluster with latest master for some experiment and saw it is creating only rbd pool by default not the data/metadata pools. Is this something changed recently ?

Thanks & Regards
Somnath

________________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
