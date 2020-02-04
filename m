From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 09/15] rbd: count pending object requests in-line
Date: Tue, 4 Feb 2020 07:59:24 +0100
Message-ID: <5bba85ee-7368-3573-cf27-f80875669571@suse.de>
References: <20200131103739.136098-1-hare@suse.de>
 <20200131103739.136098-10-hare@suse.de>
 <CAOi1vP9Z=7XPO3N7jajEG0eJDSUF+xnvn+arfU-waubra9pg-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <CAOi1vP9Z=7XPO3N7jajEG0eJDSUF+xnvn+arfU-waubra9pg-A@mail.gmail.com>
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Sage Weil <sage@redhat.com>, Daniel Disseldorp <ddiss@suse.com>, Jens Axboe <axboe@kernel.dk>, Ceph Development <ceph-devel@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On 2/3/20 6:47 PM, Ilya Dryomov wrote:
> On Fri, Jan 31, 2020 at 11:38 AM Hannes Reinecke <hare@suse.de> wrote:
>>
>> Instead of having a counter for outstanding object requests
>> check the state and count only those which are not in the final
>> state.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>  drivers/block/rbd.c | 41 ++++++++++++++++++++++++++++++-----------
>>  1 file changed, 30 insertions(+), 11 deletions(-)
>>
[ .. ]
> 
> This is just to be able to drop img_req->state_mutex in patch 11,
> right?
> 
correct.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
