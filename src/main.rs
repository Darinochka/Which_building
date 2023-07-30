use teloxide::prelude::*;
use std::collections::HashSet;


#[tokio::main]
async fn main() {    
    let bot = Bot::from_env();

    teloxide::repl(bot, |bot: Bot, msg: Message| async move {
        let academic: HashSet<u16> = HashSet::from([232, 233, 234, 225, 226, 228, 334, 335, 336, 338, 326, 327, 
                                      328, 329, 330, 433, 435, 425, 426, 427, 428, 429, 520, 521, 
                                      522, 512, 513, 514, 515, 612, 613, 614, 606, 607, 608, 712, 
                                      713, 714, 715, 703, 704, 705, 706, 707, 708]);

        let bot_answer: &str = match msg.text().map(|text| text.parse::<u16>()) {
            Some(text) => {
                match text {
                    Ok(num) => {
                        if academic.contains(&num) {
                            "Административный"
                        } 
                        else if num >= 800 {
                            "Небесный"
                            }
                        else {
                            "Учебный"
                            }
                        } 
                    Err(..) => "Отправь только номер аудитории."
                }
            }
            None => "Отправь мне текст (номер аудитории)."
        };

        bot.send_message(msg.chat.id, bot_answer).await?;
    
        Ok(())
    })
    .await;
}
